class Notification < ActionMailer::Base
  default_url_options[:host] = "pinger.neotericdesign.com"

  def site_down_notification(site)
    from       "notifications@pinger.neotericdesign.com"
    recipients ["servers@neotericdesign.com"]
    subject    "Pinger: Error accessing #{site.url} (#{site.name})"
    body       :site => site
  end
end
