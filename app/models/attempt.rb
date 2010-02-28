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
    self.status = 'performed'
    self.save
  end

  def failure?
    !success?
  end

  def build_request
    @response ||= Curl::Easy.new(site.url) do |c|
      c.follow_location = true
    end
  end

  def to_str
    @to_str ||= (success? ? "Successful" : "Error")
  end
  alias :title :to_str


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
