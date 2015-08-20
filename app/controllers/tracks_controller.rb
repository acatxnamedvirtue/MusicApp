class TracksController < ApplicationController
  before_action :require_user!

  def create
    @album = Album.find(track_params[:album_id])
    @band = @album.band
    @albums = @band.albums
    @track = @album.tracks.new(track_params)

    if @track.save!
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @track.errors.full_messages
      @track = Track.new
      @album = Album.find(params[:album_id])
      @band = @album.band
      @albums = @band.albums
      render :new
    end
  end

  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
    @band = @album.band
    @albums = @band.albums
  end

  def edit
    @track = Track.find(params[:id])
    @album = @track.album
    @band = @album.band
    @albums = @band.albums
  end

  def show
    @track = Track.find(params[:id])
    @album = @track.album
    @band = @album.band
  end

  def update
    @track = Track.find(params[:id])
    @album = @track.album
    @band = @album.band
    @albums = @band.albums

    if @track.update!(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      @track = Track.find(params[:id])
      @album = @track.album
      @band = @album.band
      @albums = @band.albums
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @album = @track.album
    @track.destroy
    redirect_to album_url(@album)
  end

  private
  def track_params
    params.require(:track).permit(:title, :album_id, :track_type, :lyrics, :track_number)
  end
end
