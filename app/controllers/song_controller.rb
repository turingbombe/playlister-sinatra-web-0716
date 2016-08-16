class SongController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do 
    erb :'songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    erb :'songs/show'
  end

  post '/songs' do 
    # binding.pry
    @song = Song.create(params[:song])
     # binding.pry   
    if !params[:genres].empty?
      params[:genres].each do |genre|
        @song.genres << Genre.find_or_create_by(genre)
      end
    end
    @song.artist = Artist.find_or_create_by(name: params[:artist_name][:name])
    @song.save

    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch '/songs' do
    @song = Song.find(params[:song][:id])
    if !params[:artist_name][:name].empty?
      @song.update(artist: Artist.find_or_create_by(params[:artist_name])) 
    end
    @song.save
    # binding.pry
    redirect "/songs/#{@song.slug}"
  end

end