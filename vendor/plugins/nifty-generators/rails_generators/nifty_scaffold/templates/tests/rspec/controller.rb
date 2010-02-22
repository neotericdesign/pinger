require File.dirname(__FILE__) + '/../spec_helper'
 
describe <%= plural_class_name %>Controller do
  integrate_views
  <%- if options[:make_fixture] -%>
  fixture :all
  <%- else -%>
  before(:each) do
    Factory(:<%= singular_name %>)
  end
  <%- end -%>

  <%= controller_methods 'tests/rspec/actions' %>
end
