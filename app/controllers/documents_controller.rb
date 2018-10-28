# encoding: utf-8
class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :complete, :show_document]
  before_action :resources, only: [:create, :new, :edit, :update]

  add_breadcrumb Document.model_name.human, :documents_path
  add_breadcrumb I18n.t("breadcrumb.show"), :document_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_document_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_document_path, only: [:edit, :update]

  respond_to :html
  def index
    @documents = Document.all
  end

  def show

  end

  def new
    @document = Document.new
  end

  def edit
  end

  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @document.update(document_params)
        redirect_to documents_url, notice: t('messages.update.notice', :model => "Document")
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @document.destroy
        format.html { redirect_to documents_url, notice: t('messages.destroy.notice', :model => "Document")}
      else
        format.html { redirect_to documents_url, alert: @document.destroy }
        format.json { head :no_content }
       end
    end
  end

  def load_contacts
    respond_to do |format|
      begin
        company = Company.find_by(id: params[:company_id])
        @company_contacts = company.company_contacts
      rescue
        @company_contacts = nil
      end
      format.html { render json: @company_contacts}
      format.js {}
    end
  end

  def complete
    @document.complete!
  end

  def show_document
    respond_to do |format|
      format.html
      format.pdf do
        return render pdf: "document", template: "documents/show_document.html.erb", layout: 'pdf.html', page_size: 'A4'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id] || params[:document_id])
    end

    # Only allow a trusted parameter "white list" through.
    def document_params
      params.require(:document).permit(:number, :year, :text, :date, :subject_id, :company_contact_id, :autentication, :responsible_id, :state, :file, :deleted_at)
    end

    def resources
      @companies = Company.all
      @company_contacts = @document.contacts_to_dropdown rescue Array.new
      @subjects = Subject.all
      @responsibles = CompanyContact.senders
    end
end
