def stub_remote_activity
  Curl::Easy.any_instance.stubs(:perform).returns(true)
  Curl::Easy.any_instance.stubs(:body_str).returns("Response Body")
  Curl::Easy.any_instance.stubs(:response_code).returns(200)
end
