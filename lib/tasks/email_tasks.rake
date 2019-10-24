namespace :tribal do
  
  desc "Daily Tribal Contacts Summary Report"
  task(:daily_contact_summary => :environment) do
    todays_contacts = Contact.find_todays_contacts
    if todays_contacts.size > 0
      Emailer.daily_contact_summary(todays_contacts).deliver
    end
  end

  desc "Bimonthly Tribal Contacts Summary Report"
  task(:bimonthly_contact_summary => :environment) do
    bimonthly_contacts = Contact.find_bimonthly_contacts
    if bimonthly_contacts.size > 0
      Emailer.bimonthly_contact_summary(bimonthly_contacts).deliver
    end
  end
  
end
