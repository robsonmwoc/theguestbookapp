require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  describe 'POST #create' do
    let(:params) do
      {
        entry: {
          name: 'Darth Vader',
          message: 'Together. We shall rule the Galaxy'
        }
      }
    end

    let(:invalid_params) do
      { entry: { name: 'Darth Vader' } }
    end

    it 'creates an entry successfully' do
      post :create, params

      expect(response).to redirect_to(root_path)
    end

    it 'fails to create an entry' do
      post :create, invalid_params

      expect(response).to render_template(:index)
    end
  end

  describe 'DELETE #destroy' do
    let(:entry_id) { 1 }
    let(:entry) { double(:Entry) }

    it 'removes an entry successfully' do
      expect(entry).to receive(:destroy).and_return(true)
      allow(Entry).to receive(:find).and_return(entry)

      delete :destroy, id: entry_id

      expect(response).to redirect_to(root_path)
    end

    it 'fails to remove an entry' do
      delete :destroy, id: entry_id

      expect(response).to redirect_to(root_path)
      expect(response).to have_http_status(:moved_permanently)
    end
  end
end
