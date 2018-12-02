require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'as a Guest' do
    it 'responds a 302 response (not authorized)' do
      company = create(:company, :valid_cnpj)
      get :show, params: { id: company.id }
      expect(response).to have_http_status(302)
    end
  end

  describe 'as Logged Member' do
    before do
      @user = create(:user)
      @company = create(:company, :valid_cnpj)
    end

    it 'Route' do
      is_expected.to route(:get, '/companies').to(action: :index)
    end

    it 'Flash Notice' do
      company_params = attributes_for(:company, :valid_cnpj)
      sign_in @user
      post :create, params: { company: company_params }
      expect(flash[:notice]).to match(I18n.t("messages.create.notice"))
    end

    it 'with valid attributes' do
      company_params = attributes_for(:company, :valid_cnpj)
      sign_in @user
      expect{
        post :create, params: { company: company_params }
      }.to change(Company, :count).by(1)
    end

    it 'with invalid attributes' do
      company_params = attributes_for(:company, cnpj: nil)
      sign_in @user
      expect{
        post :create, params: { company: company_params }
      }.not_to change(Company, :count)
    end

    it 'responds a 200 response' do
      sign_in @user
      get :show, params: { id: @company.id }
      expect(response).to have_http_status(200)
    end

    it 'render a :show template' do
      sign_in @user
      get :show, params: { id: @company.id }
      expect(response).to render_template(:show)
    end
  end
end
