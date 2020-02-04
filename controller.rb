require("sinatra")
require("sinatra/contrib/all") if development?
require('pry-byebug')
require_relative('./models/film')
# require_relative('./console')
also_reload('./models/*')

get '/index' do
  @films = Film.all
  erb(:index)
end

get '/film/:film_id' do
  @film = Film.find_by_id(params[:film_id])
  erb(:film)
end
