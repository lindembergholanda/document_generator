# encoding: utf-8
class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :resources, only: [:create, :new, :edit, :update]

  add_breadcrumb Subject.model_name.human, :subjects_path
  add_breadcrumb I18n.t("breadcrumb.show"), :subject_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_subject_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_subject_path, only: [:edit, :update]

  respond_to :html
  def index
    @subjects = Subject.all
  end

  def show

  end

  def new
    @subject = Subject.new
  end

  def edit
  end

  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to subjects_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @subject.update(subject_params)
        redirect_to subjects_url, notice: t('messages.update.notice', :model => "Subject")
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @subject.destroy
        format.html { redirect_to subjects_url, notice: t('messages.destroy.notice', :model => "Subject")}
      else
        format.html { redirect_to subjects_url, alert: @subject.errors.full_messages[0] }
        format.json { head :no_content }
       end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subject_params
      params.require(:subject).permit(:description, :text, :document_type_id, :deleted_at)
    end

    def resources
      @document_types = DocumentType.all
    end
end
