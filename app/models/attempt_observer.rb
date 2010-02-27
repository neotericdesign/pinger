class AttemptObserver < ActiveRecord::Observer
  def after_save(attempt)
    if attempt.status == 'performed' && attempt.failure?
      Rails.logger.info("\n\n***** Error accessing #{attempt.site.name}! *****\n\n")
      send_mail_for_attempt(attempt)
    end
  end

  private

  def send_mail_for_attempt(attempt)
    Notification.deliver_site_down_notification(attempt.site)
  end
end