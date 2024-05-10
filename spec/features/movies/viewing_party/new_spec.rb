require 'rails_helper'

RSpec.describe 'new viewing party', type: :feature do
  describe 'As a user' do
    before(:each) do
      @user = User.create!(name: 'Tommy', email: 'tommy@email.com')

      @movie = { genre: "Drama, Crime",
      id: 278,
      runtime: 142,
      summary: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
      title: "The Shawshank Redemption",
      vote_average: 8.704
    }
    end

    # us-4
    it 'can add a movie to a viewing party', :vcr do
      # When I visit the new viewing party page ('/users/:user_id/movies/:movie_id/viewing_party/new', where      :user_id is a valid user's id and :movie_id is a valid Movie id from the API),
      visit new_user_movie_viewing_party_path(@user, @movie[:id])
      # I should see the name of the movie title rendered above a form with the following fields:
      expect(page).to have_content(@movie[:title])
      # - Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie
      fill_in 'duration', with: '180'
      # - When: field to select date
      fill_in 'date', with: '2222-01-01'
      # - Start Time: field to select time
      fill_in 'time', with: '03:09 AM'
      # - Guests: three (optional) text fields for guest email addresses 
      expect(page).to have_field('guest1')
      expect(page).to have_field('guest2')
      expect(page).to have_field('guest3')
      # - Button to create a party
      click_button('Submit')

      expect(current_path).to eq(discover_user_path(@user))
    end
  end
end