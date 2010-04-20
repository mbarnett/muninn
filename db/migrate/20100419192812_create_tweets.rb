class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :historic_tweets do |t|
      t.string :content
      t.integer :user_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :historic_tweets
  end
end
