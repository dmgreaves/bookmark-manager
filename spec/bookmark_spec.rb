require 'bookmark'

describe Bookmark do
 it 'returns a list of bookmarks' do
   list = Bookmark.all
   expect(list).to include('http://www.google.com')
 end

end
