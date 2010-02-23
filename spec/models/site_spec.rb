require 'spec/spec_helper'

describe Site do
  should_have_many :attempts
  should_have_one  :last_attempt, :class_name => 'Attempt'
end
