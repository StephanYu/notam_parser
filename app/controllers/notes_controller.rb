class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def index
    @notes = Note.all
  end

  def create
    if Note.create_multiple_from(params[:note_file])
      redirect_to notes_path, success: 'Uploaded correctly'
    else 
      flash[:error] = 'There was an error uploading and parsing the file'
      render :new
    end
  end
end 

