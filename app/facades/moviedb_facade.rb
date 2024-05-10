class MoviedbFacade
  def self.top_rated
    get_first_20(MoviedbService.call_db('/3/movie/top_rated')[:results])
  end

  def self.search_title(search)
    params = { query: search }
    get_first_20(MoviedbService.call_db('/3/search/movie', params)[:results])
  end

  def self.movie_by_id(id)
    movie        = MoviedbService.call_db("/3/movie/#{id}")
    movie[:revs] = MoviedbService.call_db("/3/movie/#{id}/reviews")[:results]
    movie[:cast] = MoviedbService.call_db("/3/movie/#{id}/credits")[:cast]
    Moviedb.new(movie)
  end

  private

  def self.get_first_20(movies)
    movies.map { |movie| Moviedb.new(movie) }.first(20)
  end
end
