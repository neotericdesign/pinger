Given(/^the following sites?:$/) do |table|
  stub_remote_activity
  table.hashes.each do |site_attrs|
    Factory(:site, site_attrs)
  end
end

When /^"([^\"]*)" has an unsuccessful attempt$/ do |site_name|
  site = Site.find_by_name(site_name)
  site.attempts.create(:status => 'performed', :success => false)
end

