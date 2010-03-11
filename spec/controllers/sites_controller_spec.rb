require 'spec/spec_helper'

describe SitesController do
  integrate_views

  it "should be itself (zen)" do
    SitesController.should be_true
  end

  it "POST create should redirect to index when valid" do
    Site.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(sites_path)
  end

  it "PUT update should redirect to index when valid" do
    site = Factory(:site)
    Site.any_instance.stubs(:valid?).returns(true)
    put :update, :id => site.id
    response.should redirect_to(sites_path)
  end
end
