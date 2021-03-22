require 'pg'

class Bookmark

  def initialize
  end

  def self.all
    # bookmarks = ["github.com"]
    @array = []
    con = PG.connect :dbname => 'bookmark_manager'

    rs = con.exec "SELECT * FROM bookmarks"

    rs.each do |row|
      p row['url']
      @array << row['url']
    end
    return @array
  end
end
