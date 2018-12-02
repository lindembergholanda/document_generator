require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'as a Guest' do
    it 'responds a 302 response (not authorized)' do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  describe 'as Logged Member' do
    before do
      @user = create(:user)
    end

    context '#index' do
      it 'responds successfully' do
        sign_in @user
        get :index
        expect(response).to be_success
      end

      it 'responds a 200 response' do
        sign_in @user
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end
end