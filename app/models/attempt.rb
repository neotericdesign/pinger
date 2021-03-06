# == Schema Information
# Schema version: 20100223164754
#
# Table name: attempts
#
#  id         :integer         not null, primary key
#  site_id    :integer
#  success    :boolean
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Attempt < ActiveRecord::Base
  belongs_to :site
  validates_presence_of :site_id
  attr_reader :response

  default_scope :order => 'attempts.updated_at DESC'

  def perform!
    build_request
    @response.perform
    self.success = response_successful?
  rescue
    self.success = false
  ensure
    self.status = 'performed'
    self.save
  end

  def failure?
    !success?
  end

  def build_request
    @response ||= Curl::Easy.new(site.url) do |c|
      c.follow_location = true
      c.connect_timeout = AppConfig.timeout || 20 #seconds
    end
  end

  def to_str
    @to_str ||= (success? ? "Successful" : "Error")
  end
  alias :title :to_str

  def self.prune_old_records
    self.destroy_all(['updated_at < ? AND success = ?', 2.weeks.ago, false])
    self.destroy_all(['updated_at < ? AND success = ?', 1.week.ago, true])
  end

  protected
  def response_successful?
    return false unless @response.response_code == 200
    if site.keystone
      !!Regexp.new(site.keystone).match(@response.body_str)
    else
      true
    end
  end
end
