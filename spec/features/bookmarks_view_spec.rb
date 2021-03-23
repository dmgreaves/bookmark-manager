describe 'BookmarkManager' do
  feature 'View bookmarks' do
    scenario 'User can view bookmarks' do
      #connect to test database
      con = PG.connect(dbname: 'bookmark_manager_test')

      #add test data
      con.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")

      visit('/')
      click_button('Bookmarks')
      expect(page).to have_content('http://www.makersacademy.com')
    end
  end
end
