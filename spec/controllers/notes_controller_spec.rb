require 'rails_helper'

describe NotesController do
  describe 'GET new' do
    it "sets the @note variable" do
      get :new
      expect(assigns(:note)).to be_instance_of(Note)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET index' do
    it 'assigns @notes' do
      note = Note.create
      get :index
      expect(assigns(:notes)).to eq([note])
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST create' do
    context 'successful note input' do
      before do
        @file = File.open("valid_only.txt") # mock params["note_file"] for text file
        post :create,  { note_file: @file }
      end

      xit 'returns a 200 OK status' do
        expect(response).to have_http_status(:ok)
      end

      xit 'redirects the user to the note index page' do
        expect(response).to redirect_to notes_path
      end
    end

    context 'unsuccessful note input' do
      before { post :create,  { note_file:  "" } }

      xit 'returns a type of error status code' do
        expect(response).to have_http_status(:error)
      end

      xit 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end
end
