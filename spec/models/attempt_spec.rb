# == Schema Information
# Schema version: 20100223164754
#
# Table name: attempts
#
#  id         :integer         not null, primary key
#  site_id    :integer
#  success    :boolean
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec/spec_helper'

describe Attempt do
  should_belong_to :site
  should_validate_presence_of :site_id

  before(:each) do
    stub_remote_activity
    @site = Factory(:site, :name => 'The Google', :url => 'http://www.google.com')
  end

  context "success and failures (Curl)" do
    before do
      @attempt = Factory(:attempt, :site => @site)
    end

    it "should be marked successful for 200 HTTP code" do
      # Curl::Easy.any_instance.stubs(:response_code).returns(200)
      @attempt.perform!
      @attempt.should be_success
    end

    it "should not be marked successful for 404 HTTP code" do
      Curl::Easy.any_instance.stubs(:response_code).returns(404)
      @attempt.perform!
      @attempt.should be_failure
    end

    context "when site has keystone" do
      before do
        @site.stubs(:keystone).returns("text to find")
      end

      it "should be successful if the keystone text is in the response body" do
        Curl::Easy.any_instance.stubs(:body_str).returns("<h1>This text contains the text to find.</h1>")
        @attempt.perform!
        @attempt.should be_success
      end

      it "should not be successful if the keystone text is missing" do
        Curl::Easy.any_instance.stubs(:body_str).returns("<h1>Nope, it's not here</h1>")
        @attempt.perform!
        @attempt.should be_failure
      end
    end


  end

  it "should follow redirects" do
    site = Factory(:site, :url => 'http://neotericdesign.com')
    site.check!
    site.last_attempt.should be_success
  end
end
