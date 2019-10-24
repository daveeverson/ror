class ContactsController < ApplicationController
  before_filter :set_employee

  def index
    session[:home] = "tribal_contacts"
    @contact = @employee.contacts.build(:contact_date=>Time.now.strftime('%m/%d/%Y'))

    @contacts = Contact.find(:all, :limit=>10, :order=>"created_at DESC")
    flash[:result] = "10 Most Recent Tribal Contacts"

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /contacts/1
  def show
    @contact = Contact.find(params[:id])
  end

  # GET /contacts/new
  def new
    @contact = @employee.contacts.build(:contact_date=>Time.now.strftime('%m/%d/%Y'))
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    raise AuthorizationException.new unless current_user.can_edit?(@contact)
  end

  def create
   if params[:commit] != "Cancel" #cancel button
      @contact = @employee.contacts.build(params[:contact])
      if @contact.save 
        flash[:notice] = "New Tribal Contact Successfully Recorded.".html_safe
      else
        flash[:notice] = @contact.errors.full_messages.join(", ")
        @employee = @contact.author 
      end
   end
    redirect_to :action=>"index"
  end

  def update
    @contact = Contact.find(params[:id])
    raise AuthorizationException.new unless current_user.can_edit?(@contact)
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        flash[:notice] = "Tribal Contact Successfully Updated"
        format.html { redirect_to :action=>"confirm", :id=>@contact.id }
      else  
        flash[:notice] = @contact.errors.full_messages.join(", ")
        format.html { render :action=>"edit", :id=>@contact.id }
      end        
    end
  end

  def confirm
    @contact = Contact.find(params[:id])
  end

  # DELETE /contacts/1
  def destroy
    @contact = Contact.find(params[:id])
    raise AuthorizationException.new unless current_user.admin?

    if @contact.destroy
      redirect_to :action=>"index"
    else  
      render :action=>"edit"
    end
  end

  def contact_export

    if current_user.admin?
      if params[:search]
        @contacts = Contact.search(params[:search])
      else
        @contacts = Contact.find(:all, :limit=>10, :order=>"created_at DESC")
        flash[:result] = "10 Most Recent Tribal Contacts"
      end
    else
      if params[:search]
        @contacts = @employee.contacts.search(params[:search])
      else
        @contacts = @employee.contacts.all(:limit=>10, :order=>"created_at DESC")
        flash[:result] = "Your 10 Most Recent Tribal Contacts"
      end
    end

    respond_to do |format|
      format.html
      format.csv { send_data Contact.to_csv(@contacts) }
      format.xls
    end
  end

  def contact_search
    @contact = Contact.new
    @search = params[:contact_search]

    if current_user.admin?
      @contacts = Contact.search(params[:contact_search])
    else
      @contacts = @employee.contacts.search(params[:contact_search])
    end

    @result_count = @contacts.size
    
    respond_to do |format|
      flash[:result] = "Search returned #{@result_count} results."
      format.html { render :partial => 'contact_search', :content_type => 'text/html' }
    end
  end


  # Report of recent contacts
  def view_compiled_report
    @contacts = Contact.find_todays_contacts
    render :template=>"emailer/daily_contact_summary"
  end

  private

  def set_employee
    #authorized_user = current_user
    #if Employee.exists?(:username => authorized_user.user_name)
    #  @employee = Employee.find(:first,
    #                            conditions: ['lower(username) = ?', authorized_user.user_name.downcase])
    #else  
      @employee = Employee.create(:first_name=>'Dave',
                                  :last_name=>'Everson',
                                  :email_addr=>'david.everson@state.mn.us',
                                  :unit_name=>12,
                                  :username=>'eversd1',
                                  :seid=>123)
    #end
  end
end
