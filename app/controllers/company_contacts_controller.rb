# encoding: utf-8
class CompanyContactsController < ApplicationController
  before_action :set_company_contact, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Company_contacts", :company_contacts_path
  add_breadcrumb I18n.t("breadcrumb.show"), :company_contact_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_company_contact_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_company_contact_path, only: [:edit, :update]

  respond_to :html
  def index
    @company_contacts = CompanyContact.all
  end

  def show

  end

  def new
    @company_contact = CompanyContact.new
  end

  def edit
  end

  def create
    @company_contact = CompanyContact.new(company_contact_params)

    respond_to do |format|
      if @company_contact.save
        format.html { redirect_to company_contacts_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @company_contact }
      else
        format.html { render :new }
        format.json { render json: @company_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @company_contact.update(company_contact_params)
        redirect_to company_contacts_url, notice: t('messages.update.notice', :model => "Company_contact")
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @company_contact.destroy
        format.html { redirect_to company_contacts_url, notice: t('messages.destroy.notice', :model => "Company_contact")}
      else
        format.html { redirect_to company_contacts_url, alert: @company_contact.errors.full_messages[0] }
        format.json { head :no_content }
       end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company_contact
      @company_contact = CompanyContact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def company_contact_params
      params.require(:company_contact).permit(:name, :occupation, :email, :company_id, :deleted_at)
    end
end
