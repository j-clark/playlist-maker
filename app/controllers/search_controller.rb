class SearchController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    @songs = SongService.find_by(song_search_params)

    render nothing: true
  end

  private

  def song_search_params
    params[:search]
  end
end
