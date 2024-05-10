class MoviesController < ApplicationController
  def index
		@user = User.find(params[:user_id])
		if params[:top_rated]
			@movies = MoviedbFacade.top_rated
		else
			@movies = MoviedbFacade.search_title(params[:keyword])
    end
	end

	def show 
		@user  = User.find(params[:user_id])
		@movie = MoviedbFacade.movie_by_id(params[:id])
	end
end
