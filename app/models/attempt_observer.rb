class AttemptObserver < ActiveRecord::Observer
  def after_save(attempt)
    if attempt.status == 'performed' && attempt.failure?
      Rails.logger.info("\n\n***** Error accessing #{attempt.site.name}! *****\n\n")
      attempt.site.deliver_site_down_if_needed
    end
  end
end