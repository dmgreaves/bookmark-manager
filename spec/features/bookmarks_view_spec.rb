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
    scenario 'Check the new bookmark is a valid URL' do
      visit('/bookmarks/new')
      fill_in('url', with: 'Not a real bookmark')
      click_button('Add Bookmark')

      expect(page).not_to have_content "Not a real bookmark"
      expect(page).to have_content "You must submit a valid URL!"
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

 feature 'Add comments to bookmarks' do
   scenario 'a new comment is added to a bookmark' do
     bookmark = Bookmark.add(url: 'http://www.moonpig.com', title: 'Moonpig')

     visit('/bookmarks')
     first('.bookmark').click_button 'Add Comment'
     expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"

     fill_in 'comment', with: 'This is a test comment on this bookmark'
     click_button 'Submit'

     expect(current_path).to eq '/bookmarks'
     expect(first('.bookmark')).to have_content 'This is a test comment on this bookmark'
   end
 end
end
