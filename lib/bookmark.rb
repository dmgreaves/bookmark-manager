require 'pg'

class Bookmark

  def initialize
  end

  def self.all
    @array = []
      if ENV['ENVIRONMENT'] == 'test'
        con = PG.connect :dbname => 'bookmark_manager_test'
      else
        con = PG.connect :dbname => 'bookmark_manager'
      end

    rs = con.exec "SELECT * FROM bookmarks"
    rs.each do |row|
      p row['url']
      @array << row['url']
    end
    return @array
  end

  def self.add(url:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end

    con.exec("INSERT INTO bookmarks (url) VALUES('#{url}')")
  end
end
