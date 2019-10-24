class TribalEntity < ActiveRecord::Base

  has_many :contacts
  attr_accessible :name
	# validates_presence_of :name
	# validates_uniqueness_of :name

end