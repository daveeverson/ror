class Emailer < ActionMailer::Base

  def daily_contact_summary(contacts)
    @contacts = contacts
    mail(:to => "TRIBAL_CONTACT.DNR@state.mn.us",
    	:from => "no-reply.DNR@state.mn.us",
    	:bcc => "greg.massaro@state.mn.us",
    	:subject => "DNR Tribal Contacts Summary")
  end

  def bimonthly_contact_summary(contacts)
    @contacts = contacts
    mail(:to => "TRIBAL_CONTACT_ADMIN.DNR@state.mn.us",
    	:from => "no-reply.DNR@state.mn.us",
    	:bcc => "greg.massaro@state.mn.us",
    	:subject => "DNR Tribal Contacts: Bi-Monthly Summary")
  end 

end
