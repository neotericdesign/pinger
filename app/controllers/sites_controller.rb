class SitesController < InheritedResources::Base

  def create
    create! { sites_path }
  end

  def update
    update!{ sites_path }
  end

  ##
  # POST /sites/1/check
  def check
    @site ||= Site.find(params[:id])
    @site.check!
    render :json => @site.to_json(:methods => :last_attempted_at, :include => :last_attempt)
  end

  protected

  def collection
    @sites ||= end_of_association_chain.all(:include => :last_attempt, :order => 'sites.name ASC')
  end
end
