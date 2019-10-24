# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Contacts::Application.initialize!

Date::DATE_FORMATS.merge!(:default => "%m/%d/%Y")

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :address => "edge.ead.state.mn.us",
  :port => 25,
  :domain => "edge.ead.state.mn.us" ,
  #delete for production?: 
  :openssl_verify_mode => 'none'
}

ActionMailer::Base.default :content_type => "text/html"
