class GenresController < ApplicationController

  get '/genres' do
    @genres = Genre.all
    erb :"/genres/index"
  end

  get '/genres/:slug' do
      @genre = Genre.find_by_slug(params[:slug])
      @SGs = SongGenre.where(genre_id: @genre.id)
      @songs = @SGs.collect{|sg| Song.find_by_id(sg.song_id)}
      @artists = @songs.collect{|s| Artist.find_by_id(s.artist_id)}
    #  binding.pry
      erb :"/genres/show"
  end

end
