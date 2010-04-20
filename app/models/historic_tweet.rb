class HistoricTweet < ActiveRecord::Base
  belongs_to :user
  validates_associated :user
  validates_presence_of :content
  validates_length_of :content, :within=> 0..140, :message => 'must be between 0 and 140 characters!'
  before_create :post_to_twitter
  
  # A most-recent-first per-user history
  named_scope :history, lambda { |user| 
    { :order => "created_at DESC",
      :conditions => ['user_id = ?', user.id ] 
    }
  }
  
  def post_to_twitter
    begin
      user.twitter.update(content)
    rescue # Ye Olde lousy error handling, stop the save and flash an error message
      errors.add_to_base("An error occured while contacting twitter")
      false
    end
  end
  
end
