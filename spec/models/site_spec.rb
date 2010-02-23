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

require 'spec/spec_helper'

describe Site do
  should_have_many :attempts
  should_have_one  :last_attempt, :class_name => 'Attempt'

  it "should be able to check itself" do
    site = Factory(:site)
    site.check!
    site.last_attempt.should_not be_blank
  end
end
