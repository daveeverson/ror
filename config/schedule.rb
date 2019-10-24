# PRODUCTION CRONTAB UPDATE SYNTAX:
# RAILS_ENV=production bundle exec whenever --update-crontab tribal_contacts

env :PATH, ENV['PATH']

every :day, at: '3:30pm' do
  rake 'tribal:daily_contact_summary'
end

every '0 0 1 1,3,5,7,9,11 *' do
  rake 'tribal:bimonthly_contact_summary'
end
