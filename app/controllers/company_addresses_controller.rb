# encoding: utf-8
class CompanyAddressesController < ApplicationController
  before_action :set_company_address, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Company_addresses", :company_addresses_path
  add_breadcrumb I18n.t("breadcrumb.show"), :company_address_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_company_address_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_company_address_path, only: [:edit, :update]

  respond_to :html
  def index
    @company_addresses = CompanyAddress.all
  end

  def show

  end

  def new
    @company_address = CompanyAddress.new
  end

  def edit
  end

  def create
    @company_address = CompanyAddress.new(company_address_params)

    respond_to do |format|
      if @company_address.save
        format.html { redirect_to company_addresses_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @company_address }
      else
        format.html { render :new }
        format.json { render json: @company_address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @company_address.update(company_address_params)
        redirect_to company_addresses_url, notice: t('messages.update.notice', :model => "Company_address")
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @company_address.destroy
        format.html { redirect_to company_addresses_url, notice: t('messages.destroy.notice', :model => "Company_address")}
      else
        format.html { redirect_to company_addresses_url, alert: @company_address.destroy }
        format.json { head :no_content }
       end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_address
      @company_address = CompanyAddress.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def company_address_params
      params.require(:company_address).permit(:street_address, :number, :city_id, :zip_code, :company_id, :deleted_at)
    end
end
