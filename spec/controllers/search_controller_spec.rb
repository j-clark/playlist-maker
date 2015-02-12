describe SearchController do
  describe '#new' do
    let(:new_search) { double(:new_search) }

    before do
      allow(Search).to receive(:new).and_return(new_search)

      get :new
    end

    it 'assigns a new Search object' do
      expect(assigns(:search)).to be(new_search)
    end
  end

  describe '#create' do
    let(:songs) { double(:songs) }
    let(:search_params) do
      {
        song: 'song'
      }
    end

    before do
      allow(SongService).to receive(:find_by).with(song: 'song').and_return(songs)

      post :create, search: search_params
    end

    it 'gets results from the song repository and assigns them' do
      expect(assigns(:songs)).to be(songs)
    end
  end
end
