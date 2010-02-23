class AttemptObserver < ActiveRecord::Observer
  def after_save(attempt)
    if attempt.status == 'performed' && attempt.failure?
      Rails.logger.info("\n\n***** Error accessing #{attempt.site.name}! *****\n\n")
      send_mail_for_attempt(attempt)
    end
  end

  private

  def send_mail_for_attempt(attempt)
    return unless RAILS_ENV == 'production'
    Pony.mail(:to      => 'servers@neotericdesign.com',
              :subject => subject(attempt),
              :body    => body(attempt),
              :from    => 'no-reply@pinger.neotericdesign.com')
  end

  def body(attempt)
    details = attempt.response ? "\nResponse code was #{attempt.response.response_code}\n" : ""

    %Q[#{subject(attempt)}\n
       Please check on it at #{attempt.site.url}
       #{details}
      ].gsub(/^ +/,'')
  end

  def subject(attempt)
    "Pinger: Error accessing #{attempt.site.url} (#{attempt.site.name})"
  end
end
