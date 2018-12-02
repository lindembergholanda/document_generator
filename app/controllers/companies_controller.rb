# encoding: utf-8
class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :resources, only: [:create, :new, :edit, :update]

  add_breadcrumb Company.model_name.human, :companies_path
  add_breadcrumb I18n.t("breadcrumb.show"), :company_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_company_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_company_path, only: [:edit, :update]

  respond_to :html
  
  def index
    @companies = Company.all
  end

  def show

  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    begin
      respond_to do |format|
        if @company.update(company_params)
            format.html { redirect_to edit_company_url(@company), notice: I18n.t('messages.update.notice') }
        else
          format.html { redirect_to edit_company_url(@company), alert: @company.errors.full_messages[0] }
          format.json { head :no_content }
        end
      end
    rescue ActiveRecord::RecordNotDestroyed => e
      redirect_to edit_company_url(@company), alert: e.record.errors.full_messages[0]
    end
  end

  def destroy
    respond_to do |format|
      if @company.destroy
        format.html { redirect_to companies_url, notice: I18n.t('messages.destroy.notice')}
      else
        format.html { redirect_to companies_url, alert: @company.errors.full_messages[0] }
        format.json { head :no_content }
       end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def company_params
      params[:company].permit(:name, :trade_name, :cnpj, company_address_attributes: [:id, :zip_code, :street_address, :number, :city_id, :_destroy], company_contacts_attributes: [:id, :personal_title, :name, :occupation, :email, :send_document, :_destroy]) 
    end

    def resources
      @states = State.all
      @cities = Array.new
    end
end
