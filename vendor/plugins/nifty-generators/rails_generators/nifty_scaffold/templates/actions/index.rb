  def index
  <%- unless options[:will_paginate] -%>
    @<%= plural_name %> = <%= class_name %>.all
  <%- else -%>
    @<%= plural_name %> = <%= class_name %>.paginate :page => params[:page], :per_page => (params[:per_page] || 20)
  <%- end -%>
  end
