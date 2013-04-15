get '/' do
end

get '/:username' do
  @user = TwitterUser.find_or_create_by_name(params[:username])
  if @user.tweets.empty?
    @user.fetch_tweets!
  elsif @user.tweets_stale?
    @user.fetch_tweets!
  end
  erb :index
end
