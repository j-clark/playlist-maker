describe SongService do
  describe '.find_by' do
    context 'when there is a song in the search_params' do
      let(:search_results) { double(:search_results) }
      let(:search_params) do
        {
          song: 'song'
        }
      end

      before do
        allow(RSpotify::Track).to receive(:search).with('song').and_return(search_results)
      end

      it 'searches Spotify for the song title' do
        expect(SongService.find_by(search_params)).to be(search_results)
      end
    end
  end
end
