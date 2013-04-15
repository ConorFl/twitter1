class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |tweet|
      tweet.string :text
      tweet.datetime :tweet_time
      tweet.references :twitter_user
      tweet.timestamps
    end
    create_table :twitter_users do |user|
      user.string :name
      user.timestamps
    end
  end
end
