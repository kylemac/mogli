require "spec_helper"
describe Mogli::AppClient do
  describe "subscribing" do
    let :client do
      a=Mogli::AppClient.new('key')
      a.application_id="123"
      a
    end
    
    it "should allow you to subscribe with callback url, fields and verify token" do
      Mogli::Client.should_receive(:post).with("https://graph.facebook.com/123/subscriptions",an_instance_of(Hash))
      client.subscribe_to_model(Mogli::User,:callback_url=>"http://localhost:3000",:fields=>["username"])
    end
    
    it "should pass the type as the object field" do
      Mogli::Client.should_receive(:post).with("https://graph.facebook.com/123/subscriptions",{:body=>hash_including(:object=>"user")})
      client.subscribe_to_model(Mogli::User,:callback_url=>"http://localhost:3000",:fields=>["username"])
    end
    
    it "sends the list of fields comma separated if string" do
      Mogli::Client.should_receive(:post).with("https://graph.facebook.com/123/subscriptions",{:body=>hash_including(:fields=>"username,friends")})
      client.subscribe_to_model(Mogli::User,:callback_url=>"http://localhost:3000",:fields=>["username,friends"])
    end
    
    it "sends extra params correctly if called with a hash" do
      Mogli::Client.should_receive(:post).with("https://graph.facebook.com/123/subscriptions",{:body=>hash_including(:key1 => "val1", :key2 => 'val2')})
      client.subscribe_to_model(Mogli::User,:callback_url=>"http://localhost:3000",:key1 => 'val1', :key2 => 'val2')
    end
    
    it "sends the callback url" do
      Mogli::Client.should_receive(:post).with("https://graph.facebook.com/123/subscriptions",{:body=>hash_including(:callback_url=>"http://localhost:3000")})
      client.subscribe_to_model(Mogli::User,:callback_url=>"http://localhost:3000",:fields=>["username"])
    end
    
    it "should send the verify token if provided" do
      Mogli::Client.should_receive(:post).with("https://graph.facebook.com/123/subscriptions",{:body=>hash_including(:verify_token=>"TOKEN")})
      client.subscribe_to_model(Mogli::User,:callback_url=>"http://localhost:3000",:fields=>["username"],:verify_token=>"TOKEN")
      
    end
    
    it "Lists the existing subscriptions" do
     client.should_receive(:get_and_map_url).with("https://graph.facebook.com/123/subscriptions","Subscription")
     client.subscriptions
    end
  end

end
