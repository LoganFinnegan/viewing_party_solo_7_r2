require 'rails_helper'

RSpec.describe MoviedbService do
  VCR.use_cassette('can_make_API_call_to_database.yml') do
    it 'can make API call to database', :vcr do
      params = { query: "sparta" }
      query  = MoviedbService.call_db('/3/search/movie', params)[:results]
      result = query.first

      expect(query).to be_an Array
      expect(result).to be_a Hash

      check_hash_structure(result, :title, String)
      check_hash_structure(result, :vote_average, Float)
      check_hash_structure(result, :id, Integer)
    end
  end
end
