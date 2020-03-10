require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MovieHelper. For example:
#
# describe MovieHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MoviesHelper do
  describe ".data_load" do
    let!(:movie1) { FactoryBot.create(:movie, title: "Joker", rating: "R", description: "DC comic!", release_date: "09/12/2019", director: "Unkown")}
    let!(:movie2) { FactoryBot.create(:movie, title: "Good Bad and the Ugly", rating: "G", description: "A very old classic movie", release_date: "1966", director: "Unkown")}
  end

  describe 'helper methods' do
    it 'should return odd' do
      response = oddness(1)
      expect(response).to eq("odd")
    end
  end

  describe 'helper methods' do
    it 'should return even' do
      response = oddness(2)
      expect(response).to eq("even")
    end
  end


end