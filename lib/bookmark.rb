require 'pg'

class Bookmark
  attr_reader :title, :url
  def initialize(id:, url:, title:)
    @title = title
    @id = id
    @url = url
  end

  def self.create(url:, title:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect( dbname: 'bookmark_manager_test' )
    else
      connection = PG.connect( dbname: 'bookmark_manager' )
    end

    connection.exec( "INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}')" )

  end

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect( dbname: 'bookmark_manager_test' )
    else
      connection = PG.connect( dbname: 'bookmark_manager' )
    end

    result = connection.exec( "SELECT * FROM bookmarks;" )
    list = result.map { |bookmark| Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])}
  end

end
