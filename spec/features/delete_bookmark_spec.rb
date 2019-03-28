feature 'deleting a bookmark' do
  scenario 'when I have 2 bookmarks and I delete one' do
    bookmark_1 = Bookmark.create(url: "http://www.cnn.com", title: "CNN")
    Bookmark.create(url: "http://www.foxnews.com", title: "Mr Fox")

    visit '/bookmarks'

    expect(page).to have_content "CNN"
    expect(page).to have_content "Mr Fox"
    first('.bookmark').click_button 'Delete'

    expect(page).to have_no_content "CNN"
  end
end
