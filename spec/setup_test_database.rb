def setup_test_database
  require 'pg'
  p "Setting up test database..."
  #connect to test database
  con = PG.connect(dbname: 'bookmark_manager_test')
  #clear the bookmarks table
  con.exec("TRUNCATE bookmarks;")
end
