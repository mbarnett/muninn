class User < ActiveRecord::Base
  acts_as_authentic
  has_many :historic_tweets

  # A connection to our user's twitter account
  def twitter
  	oauth.authorize_from_access(oauth_token, oauth_secret)
	  @twitter ||= Twitter::Base.new(oauth)
  end
  
  def friends_timeline
    begin
      twitter.friends_timeline
    rescue # Send back nothing if twitter is down or other network issues occur
      nil
    end
  end
  
  def authorization=(oauth)
    save_authorization(oauth.token, oauth.secret)
  end
  
  def reset_auth_and_delete_tweets
    save_authorization(nil, nil)
    
    historic_tweets.each {|tweet| tweet.destroy }
  end
  
  private
  
  def oauth
    @oauth ||= Twitter::OAuth.new(TwitterConstants::CLIENT_TOKEN, TwitterConstants::CLIENT_SECRET)
  end
  
  def save_authorization(token, secret)
    update_attributes({
      :oauth_token => token, 
      :oauth_secret => secret,
    })
  end
  
end
