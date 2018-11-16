class SongsController < ApplicationController
  get '/songs' do
    #binding.pry
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
  #  binding.pry
    erb :"songs/new"
  end

  get '/songs/:slug' do
      @song = Song.find_by_slug(params[:slug])
  #    @SGs = SongGenre.where(song_id: @song.id)
  #    @genres = @SGs.collect{|sg| Genre.find_by_id(sg.genre_id)}
  #    @genres =@song.genre_ids.map { |gid| Genre.find_by_id(gid)}
      @genres = @song.genres
      @message = session[:message]
    #  binding.pry
      erb :'/songs/show'
  end

  patch '/songs/:slug' do
      @song = Song.find_by_slug(params[:slug])

  #    binding.pry
      @song.genre_ids = params[:genres]
      @song.genres =params[:genres].map{|g| Genre.find(g)}
      @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
  #    binding.pry
      @song.save
      session[:message] = "Successfully updated song."
      @message = "Successfully updated song."
    #  binding.pry
      redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
      @song = Song.find_by_slug(params[:slug])
      #binding.pry
      erb :'/songs/edit'
  end

  post '/songs' do
    @song = Song.new(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
#    binding.pry

    @song.genre_ids = params[:genres]
  #  binding.pry
    @song.save
    session[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
    #binding.pry
  end







end
