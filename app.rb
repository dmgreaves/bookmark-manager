require 'sinatra/base'
require './lib/bookmark_manager'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/bookmarks' do
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    erb :bookmarks
  end

  run! if app_file == $0
end
