# Handles showing all the user's historic tweets and creating new, history-tracked tweets

class HistoricTweetsController < ApplicationController
  before_filter :require_user, :require_authcode

  def index
    @tweets = HistoricTweet.history(@user)
  end

  def create
    @tweet = @user.historic_tweets.build(params[:tweet])
    
    respond_to do |format|
      if @tweet.save
        flash[:notice] = 'Tweet successfully posted to twitter.'
        
        format.html { redirect_to user_timelines_path(@user) }
        format.js
      else
        flash[:notice] = 'Your tweet could not be posted: ' + @tweet.errors.full_messages.join(", ")
        format.html { render :action => "index" }
        format.js { render :template => "historic_tweets/error.js" }
      end
    end
  end
  
end
