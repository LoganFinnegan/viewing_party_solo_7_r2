class MoviedbService
  def self.call_db(url, params = {})
    response = connection.get(url) do |request|
      request.params = params
      request.params[:api_key] = Rails.application.credentials.moviedb[:key]
    end
    JSON.parse(response.body, symbolize_names: true)
  end
      
  private
      
  def self.connection
    Faraday.new('https://api.themoviedb.org')
  end
end