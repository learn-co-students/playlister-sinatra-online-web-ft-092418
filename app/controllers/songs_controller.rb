class SongsController < ApplicationController

    get '/songs' do
        @songs = Song.all 
        erb :'songs/index'
    end

    get '/songs/new' do
        erb :'songs/new'
    end

    post '/songs' do
        #binding.pry
        song = Song.create(name: params[:name])
        song.artist = Artist.find_or_create_by(name: params[:artist_name])
        song.genres << params[:genres].map {|g| Genre.find(g)}
        song.save

        flash[:message] = "Successfully created song."

        redirect "/songs/#{song.slug}"
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        #binding.pry
        erb :'songs/edit'
    end

    patch '/songs/:slug' do
        song = Song.find_or_create_by(name: params[:name])
        song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        song.genres << params[:genres].map {|g| Genre.find(g)}    
        song.save

        flash[:message] = "Successfully updated song."

        redirect "/songs/#{song.slug}"
    end 
end
