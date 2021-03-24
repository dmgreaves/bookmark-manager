describe 'BookmarkManager' do
  feature 'View bookmarks' do
    scenario 'User can view bookmarks' do
      # #connect to test database
      # con = PG.connect(dbname: 'bookmark_manager_test')
      # #add test data
      # con.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")

      #refactored inserting data into datatbase
      Bookmark.add(title: 'Makers', url: 'http://www.makersacademy.com')

      visit('/')
      click_button('Bookmarks')
      expect(page).to have_link('Makers', href: 'http://www.makersacademy.com')
    end
  end

  feature 'Add bookmarks' do
    scenario 'User can save a website url by adding a bookmark' do
      #connect to test database
      con = PG.connect(dbname: 'bookmark_manager_test')

      visit('/bookmarks/new')
      fill_in('title', with: 'Apple')
      fill_in('url', with: 'http://www.apple.com')
      click_button('Add Bookmark')
      expect(page).to have_link('Apple', href: 'http://www.apple.com')
    end
  end
end

feature 'Delete bookmarks' do
  scenario 'User can delete bookmarks' do
    # Bookmark.add(url: 'http://www.apple.com', title: 'Apple')
    con = PG.connect(dbname: 'bookmark_manager_test')

    visit('/bookmarks/new')
    fill_in('title', with: 'Apple')
    fill_in('url', with: 'http://www.apple.com')
    click_button('Add Bookmark')
    expect(page).to have_link('Apple', href: 'http://www.apple.com')

    first('.bookmark').click_button 'Delete'

    expect(current_path). to eq '/bookmarks'
    expect(page).not_to have_link('Apple', href: 'http://www.apple.com')
  end
end

feature 'Update bookmarks' do
  scenario "User can update a bookmark record" do
    bookmark = Bookmark.add(url: 'http://www.moonpig.com', title: 'Moonpig')
    visit('/bookmarks')
    expect(page).to have_link('Moonpig', href: 'http://www.moonpig.com')

    first('.bookmark').click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: "http://www.funkypigeon.com")
    fill_in('title', with: "Funky Pigeon")
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Moonpig', href: 'http://www.moonpig.com')
    expect(page).to have_link('Funky Pigeon', href: 'http://www.funkypigeon.com')
  end
end
