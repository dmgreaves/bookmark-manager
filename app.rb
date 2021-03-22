require 'sinatra/base'
require './lib/bookmark_manager'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :index
  end

  run! if app_file == $0
end