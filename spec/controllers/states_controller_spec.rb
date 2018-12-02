require 'rails_helper'

RSpec.describe StatesController, type: :controller do
  describe 'as a Guest' do
    it 'responds a 302 response (not authorized)' do
      state = create(:state, :with_country)
      get :load_cities, params: { id: state.id }
      expect(response).to have_http_status(302)
    end
  end

  describe 'as Logged Member' do
    before do
      @user = create(:user)
      @state = create(:state, :with_country)
    end

    it 'Content-Type JSON' do
      customer_params = attributes_for(:state)
      sign_in @user
      post :load_cities, format: :json
      expect(response.content_type).to eq('application/json')
    end
  end
end