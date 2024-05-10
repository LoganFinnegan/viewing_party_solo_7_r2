class Moviedb 
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :genre,
              :summary,
              :reviews,
              :cast


  def initialize(data)
    @id            = data[:id]
    @title         = data[:original_title]
    @vote_average  = data[:vote_average]
    @runtime       = data[:runtime] 
    @genre         = data[:genres]&.map { |g| g[:name] }&.join(", ")
    @summary       = data[:overview]
    @reviews       = data[:revs] if data[:revs] 
    @cast          = first_ten_cast(data[:cast]) if data[:cast]
  end

  def first_ten_cast(members)
    members.first(10).map { |mem| { id: mem[:id], char_actor: "#{mem[:name]} as #{mem[:character]}" }}
  end
end