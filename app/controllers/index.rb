get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_or_create_by_name(params[:username])
  if @user.tweets.empty? || @user.tweets_stale?
    erb :render
  else
    @tweets = @user.tweets.limit(10)
    erb :index
  end 
end

post '/:username' do
  @user = TwitterUser.find_by_name(params[:username])
  @user.fetch_tweets!
  @tweets = @user.tweets.limit(10)
  erb :display_partial, layout: false
end

get '/refresh/:username' do
  @user = TwitterUser.find_or_create_by_name(params[:username])
  if @user.tweets.empty? || @user.tweets_stale?
    erb :render_partial, layout: false
  else
    @tweets = @user.tweets.limit(10)
    erb :display_partial, layout: false
  end
end
