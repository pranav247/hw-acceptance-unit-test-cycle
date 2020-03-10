require 'rails_helper'

RSpec.describe Movie, type: :model do

  before(:each) do
    @movie1 = FactoryBot.create(:movie, id: 1, title: "a", rating: "R", description: "t", release_date: "NA", director: "P1")
    @movie2 = FactoryBot.create(:movie, id: 2, title: "b", rating: "R", description: "e", release_date: "NA", director: "P1")
    @movie3 = FactoryBot.create(:movie, id: 3, title: "c", rating: "G", description: "s", release_date: "NA", director: "P1")
    @movie4 = FactoryBot.create(:movie, id: 4, title: "d", rating: "R", description: "s", release_date: "test")
  end

  describe 'director methods test for model in before(:each)' do
    it 'should return similar movie' do
      Movie.movies_related(@movie1[:id], {director: @movie1[:director]}).should == [@movie2, @movie3]
    end

    it 'should return empty relation' do
      Movie.movies_related(@movie4[:id], {director: @movie4[:director]}).should == []
    end
  end
end