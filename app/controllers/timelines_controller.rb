# display the user's timeline

class TimelinesController < ApplicationController
  before_filter :require_user, :require_authcode

  def index
    @tweet = @user.historic_tweets.build
    @friends_timeline = @user.friends_timeline
  end
end
