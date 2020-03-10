require 'rails_helper'
describe MoviesController do
  before(:each) do
    @movie1 = FactoryBot.create(:movie, id: 1, title: "Private Ryan", rating: "UG", description: "", release_date: "1993", director: "Unkown")
    @movie2 = FactoryBot.create(:movie, id: 2, title: "Marvel Endgame", rating: "PG", description: "", release_date: "2019", director: "Unkown")
    @movie3 = FactoryBot.create(:movie, id: 3, title: "Random", rating: "R", description: "RaNdOm ChArAcTeRs", release_date: "2002")
  end

  describe 'preexisting method test in before(:each)' do
    it 'should call find model method' do
      Movie.should_receive(:find).with('1')
      get :show, :id => '1'
    end

    it 'should render page correctoy' do
      get :index
      response.should render_template :index
    end

    it 'should redirect to appropriate url' do
      get :index, 
          {},    
          {ratings: {G: 'G', PG: 'PG'}}
      response.should redirect_to :ratings => {G: 'G', PG: 'PG'}
    end

    it 'should redirect to appropriate sort title url' do
      get :index,             
          {},                
          {sort: 'title'}   
      response.should redirect_to :sort => 'title'
    end

    it 'should redirect to appropriate sort release_date url' do
      get :index,          
          {},             
          {sort: 'release_date'}
      response.should redirect_to :sort => 'release_date'
    end

    it 'should create movie and redirect' do
      post :create,
           {:movie => { :title => "Hangover", :description => "Hilarious movie", :director => "Todd Phillips", :rating => "PG", :release_date =>"08/15/2009"}}
      response.should redirect_to movies_path
      expect(flash[:notice]).to be_present

    end
    it 'should render two movies' do
      get :index
      response.should render_template :index
    end

    it 'should update render edit view' do
      Movie.should_receive(:find).with('1')
      get :edit,
          {id: '1'}

    end

    it 'should update data correctly' do
      Movie.stub(:find).and_return(@movie1)
      put :update,
          :id => @movie1[:id],
          :movie => {title: "Conjuring", rating: "PG", description: "Horror", release_date: "02/27/2013", director: "James Wan"}
      expect(flash[:notice]).to be_present
    end
  end

  describe 'director methods test in before(:each)' do
    it 'should call appropriate model method' do
      Movie.should_receive(:movies_related).with(@movie2[:id], {'director' => @movie2[:director]})
      get :similarto, :id => @movie2[:id], :sim_dir => 'director'
    end

    it 'should redirect to homepage on invalid no director request' do
      Movie.should_receive(:movies_related).with(@movie3[:id], {'director' => @movie3[:director]})
      Movie.stub(:movies_related).with(@movie3[:id], {'director' => @movie3[:director]}).and_return(nil)
      get :similarto, :id => @movie3[:id], :sim_dir => 'director'
      expect(flash[:notice]).to be_present
      response.should redirect_to movies_path
    end
  end
end