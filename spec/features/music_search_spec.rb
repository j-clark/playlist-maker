describe 'Searching' do
  before do
    sign_in

    visit '/'
    click_on 'Search'
  end

  describe 'searching for a song' do
    context 'when the query returns results' do
      let(:song) { 'Fake Emp' }

      it 'displays a list of songs, with their artists' do
        search_for(song)

        expect(page).to have_content('Fake Empire')
        expect(page).to have_content('The National')
      end
    end

    context 'when the query returns no results' do
      let(:song) { 'Josh Clark is the coolest, the song' }

      it 'informs the user' do
        search_for(song)

        expect(page).to have_content("No results match your search for #{song}")
      end
    end
  end

  def search_for(song)
    fill_in 'Song', with: song
    click_on 'Search'
  end
end
