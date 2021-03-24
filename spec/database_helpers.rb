require 'pg'

def persisted_data(id:)
  con = PG.connect(dbname: 'bookmark_manager_test')
  result = con.query("SELECT * FROM bookmarks WHERE id = #{id};")
  result.first
end
