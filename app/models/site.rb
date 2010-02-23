# == Schema Information
# Schema version: 20100223164754
#
# Table name: sites
#
#  id          :integer         not null, primary key
#  url         :string(255)
#  keystone    :text
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Site < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  has_many :attempts, :dependent => :destroy
  has_one  :last_attempt, :class_name => 'Attempt', :conditions => {:status => 'performed'}, :order => 'updated_at DESC'

  after_create :check!

  def last_attempted_at
    return unless last_attempt
    %Q[#{time_ago_in_words(last_attempt.updated_at, true)} ago]
  end

  def check!
    attempts.create(:status => 'queued').perform!
  end

  def self.check_all!
    self.all.each(&:check!)
  end
end
