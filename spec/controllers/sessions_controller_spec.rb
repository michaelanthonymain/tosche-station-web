require 'spec_helper'

describe SessionsController do
   before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
    end

  context "#create" do
    it "should successfull create a user" do
      expect {
        post :create, provider: :twitter
      }.to change{ User.count }.by(1)
    end

    it "should successfully create a session" do
      session[:user_id].should be_nil
      post :create, provider: :twitter
      session[:user_id].should_not be_nil
    end

    it "should redirect to the root path" do
      post :create, provider: :twitter
      response.should redirect_to map_path
    end
  end

  context "#destroy" do
    before do
      post :create, provider: :twitter
    end

    it "should clear the session" do
      session[:user_id].should_not be_nil
      delete :destroy
      session[:user_id].should be_nil
    end

    it "should redirect to the home page" do
      delete :destroy
      response.should redirect_to root_path
    end
  end

end
