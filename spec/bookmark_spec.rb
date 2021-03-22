require 'bookmark'

describe Bookmark do
 it 'returns a list of bookmarks' do
   list = Bookmark.all
   expect(list).to include('github.com')
 end

end
