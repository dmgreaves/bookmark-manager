require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    erb :bookmarks
  end

  get '/bookmarks/new' do
    erb :"bookmarks/new"
  end

  post '/bookmarks' do
    Bookmark.add(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    # con = PG.connect(dbname: 'bookmark_manager_test')
    # con.exec("DELETE FROM bookmarks WHERE id = #{params['id']}")
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
end

  run! if app_file == $0
end
