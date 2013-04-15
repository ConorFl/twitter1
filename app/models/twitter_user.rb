class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def tweets_stale?
    most_recent_tweet = self.tweets.first.tweet_time
    oldest_tweet = self.tweets.last.tweet_time
    avg_time = (most_recent_tweet - oldest_tweet) / self.tweets.length.to_f


    self.tweets.last.updated_at < (Time.now - avg_time)
  end

  def fetch_tweets!
    @tweets = Twitter.user_timeline(self.name, :count => 10)
    self.tweets.destroy_all
    @tweets.each do |tweet|
      self.tweets << Tweet.create(text: tweet.text, tweet_time: tweet.created_at)
    end
  end
end
