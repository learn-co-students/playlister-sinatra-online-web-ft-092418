class ArtistsController < ApplicationController

  get '/artists' do
    @artists = Artist.all
    erb :"/artists/index"
  end

  get '/artists/:slug' do
      @artist = Artist.find_by_slug(params[:slug])
      @songs = Song.where(artist_id: @artist.id)
      @SGs=@songs.map{ |song |
        SongGenre.where(song_id: song.artist_id) }
        @SGs=@SGs.flatten

      @genres = @SGs.map{|sg| Genre.where(id: sg.genre_id)}
      @genres = @genres.flatten
    #  binding.pry
      erb :"/artists/show"
  end


end
