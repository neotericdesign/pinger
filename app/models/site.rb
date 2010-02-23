class Site < ActiveRecord::Base
  has_many :attempts, :dependent => :destroy
  has_one  :last_attempt, :class_name => 'Attempt', :conditions => {:status => 'performed'}, :order => 'updated_at DESC'

  after_create :check!

  def last_attempted_at
    last_attempt && last_attempt.updated_at.try(:to_s, :long_ordinal)
  end

  def check!
    attempts.create(:status => 'queued').perform!
  end

  def self.check_all!
    self.all.each(&:check!)
  end
end
