class <%= plural_class_name %>Controller < InheritedResources::Base
  actions :<%= controller_actions.join(', :') %>
  <%- if options[:will_paginate] -%>

  protected
  def collection
    @<%= plural_name %> ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 20)
  end
  <%- end -%>
end
