require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  describe 'as a Guest' do
    it 'responds a 302 response (not authorized)' do
      subject = create(:subject, :with_document_type)
      get :show, params: { id: subject.id }
      expect(response).to have_http_status(302)
    end
  end

  describe 'as Logged Member' do
    before do
      @user = create(:user)
      @subject = create(:subject, :with_document_type)
    end

    it 'Route' do
      is_expected.to route(:get, '/subjects').to(action: :index)
    end

    it 'Flash Notice' do
      subject_params = attributes_for(:subject, :with_document_type)
      sign_in @user
      post :create, params: { subject: subject_params }
      expect(flash[:notice]).to match(I18n.t("messages.create.notice"))
    end

    it 'with valid attributes' do
      subject_params = attributes_for(:subject, :with_document_type)
      sign_in @user
      expect{
        post :create, params: { subject: subject_params }
      }.to change(Subject, :count).by(1)
    end

    it 'with invalid attributes' do
      subject_params = attributes_for(:subject, description: nil)
      sign_in @user
      expect{
        post :create, params: { subject: subject_params }
      }.not_to change(Subject, :count)
    end

    it 'responds a 200 response' do
      sign_in @user
      get :show, params: { id: @subject.id }
      expect(response).to have_http_status(200)
    end

    it 'render a :show template' do
      sign_in @user
      get :show, params: { id: @subject.id }
      expect(response).to render_template(:show)
    end
  end
end