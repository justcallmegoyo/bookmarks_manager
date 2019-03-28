require "bookmark"

describe Bookmark do
  describe ".all" do
    it "returns all urls from bookmarks database table" do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add test data
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.makersacademy.com', 'Makers');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.destroyallsoftware.com', 'Destroy All Software');")
      connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.google.com', 'Google');")

      bookmarks = Bookmark.all

      expect(bookmarks[0]).to have_attributes(:title => "Makers")
      expect(bookmarks[1]).to have_attributes(:title => "Destroy All Software")
      expect(bookmarks[2]).to have_attributes(:title => "Google")
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      bookmarks = Bookmark.all
      expect(bookmarks[0]).to have_attributes(:url => "http://www.testbookmark.com")
      expect(bookmarks[0]).to have_attributes(:title => "Test Bookmark")
    end
  end

  describe "delete" do
    it "deletes a bookmark from the list" do
      bookmark_1 = Bookmark.create(url: 'http://www.testbookmark.com', title: 'Test Bookmark')
      bookmark_2 = Bookmark.create(url: 'http://www.johnlewis.co.uk', title: 'John Lewis')

      expect(Bookmark.all[0]).to have_attributes(:url => 'http://www.testbookmark.com')
      Bookmark.delete(bookmark_1.id)
      
      expect(Bookmark.all[0]).not_to have_attributes(:url => 'http://www.testbookmark.com')
  end
end
end
