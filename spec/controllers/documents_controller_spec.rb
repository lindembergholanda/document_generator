require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  describe 'as a Guest' do
    it 'responds a 302 response (not authorized)' do
      document = create(:document, :with_subject, :with_company_contact, :with_responsible)
      get :show, params: { id: document.id }
      expect(response).to have_http_status(302)
    end
  end

  describe 'as Logged Member' do
    before do
      @user = create(:user)
      @document = create(:document, :with_subject, :with_company_contact, :with_responsible)
    end

    it 'Route' do
      is_expected.to route(:get, '/documents').to(action: :index)
    end

    it 'Flash Notice' do
      document_params = attributes_for(:document, :with_subject, :with_company_contact, :with_responsible)
      sign_in @user
      post :create, params: { document: document_params }
      expect(flash[:notice]).to match(I18n.t("messages.create.notice"))
    end

    it 'with valid attributes' do
      document_params = attributes_for(:document, :with_subject, :with_company_contact, :with_responsible)
      sign_in @user
      expect{
        post :create, params: { document: document_params }
      }.to change(Document, :count).by(1)
    end

    it 'with invalid attributes' do
      document_params = attributes_for(:document, cnpj: nil)
      sign_in @user
      expect{
        post :create, params: { document: document_params }
      }.not_to change(Document, :count)
    end

    it 'responds a 200 response' do
      sign_in @user
      get :show, params: { id: @document.id }
      expect(response).to have_http_status(200)
    end

    it 'render a :show template' do
      sign_in @user
      get :show, params: { id: @document.id }
      expect(response).to render_template(:show)
    end
  end
end