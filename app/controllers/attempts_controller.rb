class AttemptsController < InheritedResources::Base
  actions :index
  optional_belongs_to :site
end
