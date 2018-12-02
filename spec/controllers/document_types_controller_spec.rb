require 'rails_helper'

RSpec.describe DocumentTypesController, type: :controller do
  describe 'as a Guest' do
    it 'responds a 302 response (not authorized)' do
      document_type = create(:document_type)
      get :show, params: { id: document_type.id }
      expect(response).to have_http_status(302)
    end
  end

  describe 'as Logged Member' do
    before do
      @user = create(:user)
      @document_type = create(:document_type)
    end

    it 'Route' do
      is_expected.to route(:get, '/document_types').to(action: :index)
    end

    it 'Flash Notice' do
      document_type_params = attributes_for(:document_type)
      sign_in @user
      post :create, params: { document_type: document_type_params }
      expect(flash[:notice]).to match(I18n.t("messages.create.notice"))
    end

    it 'with valid attributes' do
      document_type_params = attributes_for(:document_type)
      sign_in @user
      expect{
        post :create, params: { document_type: document_type_params }
      }.to change(DocumentType, :count).by(1)
    end

    it 'with invalid attributes' do
      document_type_params = attributes_for(:document_type, description: nil)
      sign_in @user
      expect{
        post :create, params: { document_type: document_type_params }
      }.not_to change(DocumentType, :count)
    end

    it 'responds a 200 response' do
      sign_in @user
      get :show, params: { id: @document_type.id }
      expect(response).to have_http_status(200)
    end

    it 'render a :show template' do
      sign_in @user
      get :show, params: { id: @document_type.id }
      expect(response).to render_template(:show)
    end
  end
end