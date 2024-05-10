class MovieReviews
  attr_reader :id,
              :author,
              :review

  def initialize(data)
    @id     = data[:id]
    @author = data[:author]
    @review = data[:content]
  end
end