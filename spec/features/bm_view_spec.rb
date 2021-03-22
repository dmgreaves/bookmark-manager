describe 'BookmarkManager' do
  feature 'View bookmarks' do
    scenario 'User can view bookmarks' do
      visit('/')
      click_button('Bookmarks')
      expect(page).to have_content("Bookmarks")
    end
  end
end
