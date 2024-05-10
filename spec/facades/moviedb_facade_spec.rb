require 'rails_helper'

RSpec.describe MoviedbFacade do
  # VCR.use_cassette('lists_top_rated_movies.yml') do 
    it 'lists top rated movies', :vcr do
      movies = MoviedbFacade.top_rated
      movie  = movies.first 
      
      expect(movies).to be_an(Array)
      expect(movies.count).to eq(20)
      expect(movie).to be_a(Moviedb)
      expect(movie.id).to be_an(Integer)
      expect(movie.title).to be_a(String)
      expect(movie.vote_average).to be_a(Float)
    end
  # end
  
  VCR.use_cassette('can_search_by_movie_title.yml') do
    it 'can search by movie title', :vcr do 
      movies = MoviedbFacade.search_title('Spider')
      movie  = movies.first 

      expect(movies).to be_an(Array)
      expect(movies.count).to eq(20)
      expect(movie).to be_a(Moviedb)
      expect(movie.id).to be_an(Integer)
      expect(movie.title).to be_a(String)
      expect(movie.vote_average).to be_a(Float)
    end
  end
end