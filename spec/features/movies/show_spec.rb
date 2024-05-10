require 'rails_helper'

RSpec.describe 'user movies show spec', type: :feature do
  before(:each) do
    @user = User.create!(name: 'Tommy', email: 'tommy@email.com')

    @movie = { 
      genre: "Drama, Crime",
      id: 278,
      runtime: 142,
      summary: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
      title: "The Shawshank Redemption",
      vote_average: 8.704
    }

    @review = {  
      author: "elshaarawy",
      id: "5723a329c3a3682e720005db",
      review: "very good movie 9.5/10 محمد الشعراوى"
    }

    @cast = { 
      adult: false,
      gender: 2,
      id: 504,
      known_for_department: "Acting",
      name: "Tim Robbins",
      original_name: "Tim Robbins",
      popularity: 34.446,
      profile_path: "/A4fHNLX73EQs78f2G6ObfKZnvp4.jpg",
      cast_id: 3,
      character: "Andy Dufresne",
      credit_id: "52fe4231c3a36847f800b131",
      order: 0
    }
  end
    # us-3 
  VCR.use_cassette('can_display_movie_attributes.yml') do
    it 'can display movie attributes', :vcr do
      # When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`) where :id is a valid user id,
      visit user_movie_path(@user, @movie[:id])
      # I should see
      # - a button to Create a Viewing Party
      expect(page).to have_content('Create a Viewing Party')
      # - a button to return to the Discover Page
      expect(page).to have_content('Return to the Discover Page')
      # I should also see the following information about the movie:
      # - Movie Title
      expect(page).to have_content(@movie[:title])
      # - Vote Average of the movie
      expect(page).to have_content(@movie[:vote_average])
      # - Runtime in hours & minutes
      expect(page).to have_content(@movie[:runtime])
      # - Genre(s) associated to movie
      expect(page).to have_content(@movie[:genre])
      # - Summary description
      expect(page).to have_content(@movie[:summary])
      #  - List the first 10 cast members (characters & actress/actors)
      within "#cast-#{@cast[:id]}" do
            expect(page).to have_content(@cast[:name])
            expect(page).to have_content(@cast[:character])
      end

      # - Count of total reviews
      expect(page).to have_content('Review Count: 13')
      within "#review-#{@review[:id]}" do
      # - Each review's author and information
        expect(page).to have_content(@review[:author])

        expect(page).to have_content(@review[:review])
      end
    end
  end
end