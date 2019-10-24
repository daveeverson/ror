require 'net/ldap'

class AuthorizedUser

  ADMIN = ['Admin', '10'].freeze
   
  attr_reader :user_name, :employee_nbr, :is_employee, :employee_email,
              :employee_unit, :first_name, :last_name
  
  def initialize(user_name, role)
    @user_name = user_name
    @role = role
    @employee_nbr = get_employee_info["employee_id"]
    @employee_email = get_employee_info["employee_email"]
    @employee_unit = get_employee_info["employee_unit"]
    @first_name = get_employee_info["first_name"]
    @last_name = get_employee_info["last_name"]
  end
  
  def admin?
    # toggle for development testing access rights
    # @role.in? ADMIN
    true
  end

  def can_edit?(contact)
    # if admin?
    #   true
    # elsif contact.employee
    #   employee_email.downcase == contact.employee.email_addr.downcase
    # else
    #   false
    # end
    true
  end

  private

  def get_employee_info
    @cache ||= ldap_search
    @cache
  end
  
  def ldap_search
    ldap = Net::LDAP.new :host=>"156.98.35.114",
          :port=>389,
          :auth=>{
            :method=>:simple,
            :username=>"CN=LDAP User, OU=MRG, dc=mndnr, dc=dnr, dc=state, dc=mn, dc=us",
            :password=>"Passw0rd"
          }    
    filter = Net::LDAP::Filter.eq("sAMAccountName", "#{@user_name}")
    treebase = "DC=mndnr,DC=dnr,DC=state,DC=mn,DC=us"
    
    employee_id = nil
    employee_email = nil
    employee_unit = nil
    employee_fname = nil
    employee_lname = nil
    
    ldap.search( :base => treebase, :filter => filter ) do |entry|
      employee_id = entry[:employeenumber].join.strip
      employee_email = entry[:mail].join.strip
      employee_unit = entry[:department].join.strip
      employee_fname = entry[:givenname].join.strip
      employee_lname = entry[:sn].join.strip
    end
    
    ldap = nil
    Hash["employee_id", employee_id, "employee_email", employee_email,
         "employee_unit", employee_unit, "last_name", employee_lname,
         "first_name", employee_fname]
  end
end
