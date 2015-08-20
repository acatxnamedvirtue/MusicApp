class NotesController < ApplicationController
  before_action :require_user!
  before_action :confirm_author!, only: :destroy

  def show
    @note = Note.find(params[:id])
  end

  def create
    @track = Track.find(note_params[:track_id])
    params[:note][:user_id] = current_user.id
    @note = @track.notes.new(note_params)

    if @note.save!
      redirect_to track_url(@track)
    else
      @track = Track.find(note_params[:track_id])
      @note = @track.notes.new(note_params)
      render :new
    end
  end

  def new
    @note = Note.new
    @track = Track.find(params[:track_id])
    @album = @track.album
    @band = @album.band
  end

  def destroy
    @note = Note.find(params[:id])
    @track = @note.track
    @note.destroy!
    redirect_to track_url(@track)
  end

  private
  def note_params
    params.require(:note).permit(:track_id, :user_id, :text)
  end

  def confirm_author!
    render text: "You are not the author!" unless current_user == Note.find(params[:id]).user
  end
end
