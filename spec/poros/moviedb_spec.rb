require 'rails_helper'

RSpec.describe Moviedb do
  before(:each) do
    attrs = {
      id: 8,
      original_title: 'Misery',
      vote_average: 9.98
    }

    @object = Moviedb.new(attrs)
  end

  it 'can format the data from the database' do
    expect(@object).to be_a Moviedb

    results = {
      id: 8,
      title: 'Misery',
      vote_average: 9.98,
    }

    expect(@object).to have_attributes(results)
  end
end



