class ContactUnitsController < ApplicationController
  #protect_from_forgery :only => [:create, :update, :destroy]
  before_filter :check_privileges
  
  def index
    @units = ContactUnit.find(:all, :order=>"name")
  end
 
  def new
    @unit = ContactUnit.new
  end
  
  def edit
    @unit = ContactUnit.find(params[:id])
  end  

  def create
    @unit = ContactUnit.new(params[:contact_unit])
    if @unit.save 
      redirect_to :action => "edit", :id => @unit
      flash[:notice] = "Unit Successfully Created"
    else
      msgs = @unit.errors.each{|attr,msg| "#{attr} - #{msg}"}.join(',')
      flash[:error] = msgs
      redirect_to :action => "new"
    end
  end
  
  def update
    @unit = ContactUnit.find(params[:id])
    if @unit.update_attributes(params[:contact_unit])
      redirect_to :action => "edit"
      flash[:notice] = "Unit Updated Successfully"
    else  
      redirect_to :action => "edit"
    end
  end
  
  def destroy
    
  end

  private
  
  def check_privileges
    raise AuthorizationException.new unless current_user.admin?
  end
  
end
