Given(/^the following sites?:$/) do |table|
  stub_remote_activity
  table.hashes.each do |site_attrs|
    Site.any_instance.stubs(:check!)
    site = Factory(:site, site_attrs)
    Factory(:attempt, :site => site, :success => true)
  end
end

When /^"([^\"]*)" has an(?:other)? unsuccessful attempt$/ do |site_name|
  site = Site.find_by_name(site_name)
  site.attempts.create(:status => 'performed', :success => false)
end

