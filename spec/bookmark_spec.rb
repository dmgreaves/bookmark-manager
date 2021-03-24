require 'bookmark'
require 'database_helpers'

describe '.all' do
 it 'returns a list of bookmarks' do
   #connect to test database
   con = PG.connect(dbname: 'bookmark_manager_test')

   #add test data
   # con.exec("INSERT INTO bookmarks (url) VALUES ('http://www.google.com');")
   bookmark = Bookmark.add(url: 'http://www.google.com', title: 'Google')
   Bookmark.add(url: 'http://www.youtube.com', title: 'Youtube')

   # list = Bookmark.all
   # expect(list).to include('http://www.google.com')

   bookmarks = Bookmark.all
   expect(bookmarks.length).to eq 2
   expect(bookmarks.first).to be_a Bookmark
   expect(bookmarks.first.id).to eq bookmark.id
   expect(bookmarks.first.title).to eq 'Google'
   expect(bookmarks.first.url).to eq 'http://www.google.com'
 end
end

describe '.add' do
  it 'adds a new bookmark' do
    bookmark = Bookmark.add(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
    persisted_data = persisted_data(id: bookmark.id)

    # expect(bookmark['url']).to eq 'http://www.testbookmark.com'
    # expect(bookmark['title']).to eq 'Test Bookmark'
    expect(bookmark).to be_a Bookmark
    expect(bookmark.id).to eq persisted_data['id']
    expect(bookmark.title).to eq 'Test Bookmark'
    expect(bookmark.url).to eq 'http://www.testbookmark.com'
  end
end

describe '.delete' do
  it 'deletes a selected bookmark' do
    bookmark = Bookmark.add(url: 'www.apple.com', title: 'Apple')
    Bookmark.delete(id: bookmark.id)
    expect(Bookmark.all.length).to eq 0
  end
end
