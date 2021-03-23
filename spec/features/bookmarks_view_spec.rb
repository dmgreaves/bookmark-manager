describe 'BookmarkManager' do
  feature 'View bookmarks' do
    scenario 'User can view bookmarks' do
      # #connect to test database
      # con = PG.connect(dbname: 'bookmark_manager_test')
      # #add test data
      # con.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")

      #refactored inserting data into datatbase
      Bookmark.add(url: 'http://www.makersacademy.com')

      visit('/')
      click_button('Bookmarks')
      expect(page).to have_content('http://www.makersacademy.com')
    end
  end

  feature 'Add bookmarks' do
    scenario 'User can save a website url by adding a bookmark' do
      #connect to test database
      con = PG.connect(dbname: 'bookmark_manager_test')

      visit('/bookmarks/new')
      fill_in('NewBookmark', with: 'http://www.apple.com')
      click_button('Add Bookmark')
      expect(page).to have_content('http://www.apple.com')
    end
  end
end
