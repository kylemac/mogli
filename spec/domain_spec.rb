require 'spec_helper'

describe Mogli::Domain do
  # let :domain do
  #   Mogli::Domain.new
  # end
  
  describe "Finding" do
    it "finds optional fields for a user" do
      Mogli::Client.should_receive(:get).with("https://graph.facebook.com/1/insights", :query=>{:since => '213234243', :until => '21323123'}) #.and_return({:id=>1, :birthday=>'09/15', :gender => 'male'})
      domain = Mogli::Domain.find(1, nil, {:since => '213234243', :until => '21323123'})
      #user.birthday.should == '09/15'
      #user.gender.should == 'male'
    end

    # it "finds a user's friends with optional fields" do
    #   mock_client.should_receive(:get_and_map).with(
    #     "1/friends", "User", {:fields => [:birthday, :gender]}).and_return(
    #     [Mogli::User.new(:id=>2, :birthday=>'09/15', :gender => 'male')])
    #   friends = user_1.friends(:birthday, :gender)
    #   friends.size.should == 1
    # end
  end
  
end