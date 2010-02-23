class Site < ActiveRecord::Base
  has_many :attempts
  has_one  :last_attempt, :class_name => 'Attempt'
end
