class Employee < ActiveRecord::Base
  
  belongs_to :unit
  
  has_many :contacts, :foreign_key=>"author_id"

  attr_accessible :first_name, :last_name, :email_addr, :unit_name, :username, :seid

  
#  validates_presence_of :unit_id
#  validates_presence_of :email_addr
#  validates_presence_of :first_name
#  validates_presence_of :last_name
#  validates_presence_of :work_phone
  
  def display_name
    "#{self.last_name}, #{self.first_name}"
  end
  
end
