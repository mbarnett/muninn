# Handles creating oauth authorization tokens from our client authorization
# and the pin the user obtains

class AuthorizationsController < ApplicationController
  before_filter :require_user
  
  # The oauth logic here is that we combine our app's token and secret to 
  # get a request. The request has its own token and secret, and a url
  # where the user can authorize access. We need to send the user to the
  # url and then stash the request token and secret for use when they come
  # back with a pin
  def new     
    request_token = twitter_oauth.get_request_token
    
    session[:token] = request_token.token
    session[:secret] = request_token.secret
    
    @auth_code_url = request_token.authorize_url
  end
  
  # Now that we have the pin the user obtained, we combine our app's token and secret
  # with the request token and secret and the pin to get an access token
  # whose constituent token and secret give us access to the user's account
  def create                       
    request_token = OAuth::RequestToken.new(twitter_oauth, session[:token], session[:secret])
    access_token = request_token.get_access_token(:oauth_verifier => params[:auth_code])
    @user.authorization = access_token

    redirect_to root_path
  end
  
  # Forget the user's access_token, wipe out recorded tweets
  def destroy
    @user.reset_auth_and_delete_tweets
    
    redirect_to root_path
  end
  
  private
  
  def twitter_oauth
     @twitter_oauth ||= OAuth::Consumer.new(TwitterConstants::CLIENT_TOKEN, 
                                            TwitterConstants::CLIENT_SECRET, 
                                           { :site=> TwitterConstants::SITE ,
                                             :request_token_path => TwitterConstants::REQUEST_PATH ,
                                             :access_token_path => TwitterConstants::ACCESS_PATH ,
                                             :authorize_path => TwitterConstants::AUTH_PATH  })
   end
end
