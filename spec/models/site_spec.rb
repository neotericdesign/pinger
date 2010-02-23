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
