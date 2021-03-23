require 'bookmark'

describe Bookmark do
 it 'returns a list of bookmarks' do
   #connect to test database
   con = PG.connect(dbname: 'bookmark_manager_test')

   #add test data
   con.exec("INSERT INTO bookmarks (url) VALUES ('http://www.google.com');")

   list = Bookmark.all

   expect(list).to include('http://www.google.com')
 end
end

describe '.add' do
  it 'adds a new bookmark' do
    Bookmark.add(url: 'http://www.testbookmark.com')

    expect(Bookmark.all).to include 'http://www.testbookmark.com'
  end
end
