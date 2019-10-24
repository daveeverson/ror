class Contact < ActiveRecord::Base
  self.table_name = "tribal_contacts"

  belongs_to :author, :class_name=>"Employee", :foreign_key=>"author_id"
	belongs_to :contact_unit, :foreign_key=>"unit_id"
  belongs_to :tribal_entity, :foreign_key=>"tribal_entity_id"
  belongs_to :employee, :foreign_key=>"author_id"

  validates_length_of :notes, :maximum=>6000  
  validates_presence_of :topic #, :message=>"Topic can not be blank. "

	attr_accessible :topic, :tribal_entity_id, :tribal_contact_first_name, :tribal_contact_last_name, :unit_id
	attr_accessible :staff_first_name, :staff_last_name, :contact_date, :notes, :author_id

  delegate :email_addr, to: :employee, prefix: true, allow_nil: true

  def self.to_csv(contacts, options = {})
    CSV.generate(options) do |csv|
      csv << ["tribe",
              "topic",
              "tribal_contact_first_name",
              "tribal_contact_last_name",
              "business_unit",
              "staff_first_name",
              "staff_last_name",
              "contact_date",
              "notes"] 
      contacts.each do |c|
        a = []
        a << c.tribal_entity.try(:name) ? c.tribal_entity.name : '' unless c.tribal_entity.blank?
        a += c.attributes.values_at(*[
              "topic",
              "tribal_contact_first_name",
              "tribal_contact_last_name"])
        
        a += [c.contact_unit.try(:name) ? c.contact_unit.name : ''] unless c.contact_unit.blank?
        a += c.attributes.values_at(*[
              "staff_first_name",
              "staff_last_name",
              "contact_date"])
        a += [CGI::unescapeHTML(c.notes.gsub(/(<[^>]*>)|\n|\r|&nbsp;|\t\/s/) {" "})]
        csv << a
      end
    end
  end

  def self.find_todays_contacts
    time_cutoff = Date.today.ago(30600) # adjusted b/c rails stored created_at in UTC 
    contacts = Contact.find(:all, :conditions=>["created_at > ?", time_cutoff], :order=>"created_at DESC")
    return contacts
  end

  def self.find_bimonthly_contacts
    time_lowrange = Date.today.months_ago(2).beginning_of_month.ago(0) # adjusted b/c rails stored created_at in UTC 
    time_hirange = Date.today.months_ago(1).end_of_month.ago(-86399) # adjusted b/c rails stored created_at in UTC 
    contacts = Contact.find(:all, :conditions=>["created_at > ? AND created_at < ?", time_lowrange, time_hirange], :order=>"created_at DESC")
    return contacts
  end

  def self.search(params)
    params[:business_unit].empty? ? bu = nil : bu = params[:business_unit].to_i
    params[:tribal_name].empty? ? te = nil : te = params[:tribal_name].to_i
    q = Contact.where("upper(topic) like ? or upper(notes) like ?", "%#{params[:topic]}%".upcase, "%#{params[:topic]}%".upcase)
    if params[:tribal_contact_first_name].present?
      q = q.where("upper(tribal_contact_first_name) like ?", "%#{params[:tribal_contact_first_name]}%".upcase)
    end
    if params[:tribal_contact_last_name].present?
      q = q.where("upper(tribal_contact_last_name) like ?", "%#{params[:tribal_contact_last_name]}%".upcase)
    end
    if params[:staff_first_name].present?
      q = q.where("upper(staff_first_name) like ?", "%#{params[:staff_first_name]}%".upcase)
    end
    if params[:staff_last_name].present?
      q = q.where("upper(staff_last_name) like ?", "%#{params[:staff_last_name]}%".upcase)
    end
    if params[:from_date].present?
      q = q.where("contact_date >= ?", "#{params[:from_date]}")
    end
    if params[:to_date].present?
      q = q.where("contact_date <= ?", "#{params[:to_date]}")
    end
    if bu
      q = q.where("unit_id = ?", "#{params[:business_unit]}")
    end
    if te
      q = q.where("tribal_entity_id = ?", "#{params[:tribal_name]}")
    end
    q=q.order(:contact_date).reverse_order
    q.all

  end

end
