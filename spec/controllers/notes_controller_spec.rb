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
      before { post :create, # mock a note_file somehow params[:note_file] }
      # expect 200 status
      xit 'creates a note' do
        expect(Note.count).to eq(1)
      end

      xit 'redirects the user to the note index page' do
        expect(response).to redirect_to notes_path
      end
    end

    context 'unsuccessful note input' do
      before { post :create, # pass empty note_file }

      xit 'does not create a note' do
        # expect flash error message
        # status code
      end

      xit 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end
end
