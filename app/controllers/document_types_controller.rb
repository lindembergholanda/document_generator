# encoding: utf-8
class DocumentTypesController < ApplicationController
  before_action :set_document_type, only: [:show, :edit, :update, :destroy]
  add_breadcrumb DocumentType.model_name.human, :document_types_path
  add_breadcrumb I18n.t("breadcrumb.show"), :document_type_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_document_type_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_document_type_path, only: [:edit, :update]

  respond_to :html
  def index
    @document_types = DocumentType.all
  end

  def show

  end

  def new
    @document_type = DocumentType.new
  end

  def edit
  end

  def create
    @document_type = DocumentType.new(document_type_params)

    respond_to do |format|
      if @document_type.save
        format.html { redirect_to document_types_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @document_type }
      else
        format.html { render :new }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @document_type.update(document_type_params)
        redirect_to document_types_url, notice: I18n.t('messages.update.notice')
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @document_type.destroy
        format.html { redirect_to document_types_url, notice: I18n.t('messages.destroy.notice')}
      else
        format.html { redirect_to document_types_url, alert: @document_type.errors.full_messages[0] }
        format.json { head :no_content }
       end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_type
      @document_type = DocumentType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def document_type_params
      params.require(:document_type).permit(:description, :deleted_at)
    end
end
