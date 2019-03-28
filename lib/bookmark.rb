require 'pg'

class Bookmark
  attr_reader :title, :url, :id
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

    result = connection.exec( "INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title" )
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
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

  def self.delete(id)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect( dbname: 'bookmark_manager_test' )
    else
      connection = PG.connect( dbname: 'bookmark_manager' )
    end

    result = connection.exec( "DELETE FROM bookmarks WHERE id = #{id};" )
  end

end
