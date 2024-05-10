require 'rails_helper'

RSpec.describe 'user discover dashboard', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user2 = User.create!(name: 'Sam', email: 'sam@email.com')

    visit register_user_path
  end
  
  # us-1
  it 'can search by title', :vcr do
    visit "/users/#{@user1.id}/discover"

    expect(page).to have_button('Discover Top Rated Movies')

    expect(page).to have_field('keyword')

    expect(page).to have_button('Search by Movie Title')
  end

  # us-2a
  VCR.use_cassette('displays_top_rated.yml') do 
    it 'displays top rated', :vcr do
      # When I visit the discover movies page ('/users/:id/discover'),
      visit "/users/#{@user1.id}/discover"
      # and click on either the Discover Top Rated Movies button or fill out the movie title search and click the Search button,
      click_button('Discover Top Rated Movies')
      # I should be taken to the movies results page (`users/:user_id/movies`) where I see: 
      expect(current_path).to eq(user_movies_path(@user1))
      # - Title (As a Link to the Movie Details page (see story #3))
      within '#movie-278' do
        expect(page).to have_content("The Shawshank Redemption")
        # - Vote Average of the movie
        expect(page).to have_content("8.7")
      end
      # I should also see a button to return to the Discover Page.
      expect(page).to have_button('Return to the Discover Page')
    end
  end
  
  # us-2b
  VCR.use_cassette('displays_searched_movies.yml') do 
    it 'displays searched movies', :vcr do
      # When I visit the discover movies page ('/users/:id/discover'),
      visit "/users/#{@user1.id}/discover"
      # and click on either the Discover Top Rated Movies button or fill out the movie title search and click the Search button,
      fill_in 'keyword', with: 'shawshank'
      click_button('Search by Movie Title')
      # I should be taken to the movies results page (`users/:user_id/movies`) where I see: 
      expect(current_path).to eq(user_movies_path(@user1))
      # - Title (As a Link to the Movie Details page (see story #3))
      within '#movie-278' do
        expect(page).to have_content("The Shawshank Redemption")
        # - Vote Average of the movie
        expect(page).to have_content("8.7")
      end
      # I should also see a button to return to the Discover Page.
      expect(page).to have_button('Return to the Discover Page')
    end
  end
end