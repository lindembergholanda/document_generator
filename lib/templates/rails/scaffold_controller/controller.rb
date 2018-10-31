# encoding: utf-8
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
  add_breadcrumb <%= singular_table_name.capitalize %>.model_name.human, :<%= plural_table_name %>_path
  add_breadcrumb I18n.t("breadcrumb.show"), :<%= singular_table_name %>_path, only: [:show]
  add_breadcrumb I18n.t("breadcrumb.new"), :new_<%= singular_table_name %>_path, only: [:new, :create]
  add_breadcrumb I18n.t("breadcrumb.edit"), :edit_<%= singular_table_name %>_path, only: [:edit, :update]

  respond_to :html
  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end

  def show

  end

  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def edit
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    respond_to do |format|
      if @<%= orm_instance.save %>
        format.html { redirect_to <%= plural_table_name %>_url, notice: I18n.t("messages.create.notice") }
        format.json { render :show, status: :created, location: @<%= singular_table_name %> }
      else
        format.html { render :new }
        format.json { render json: @<%= orm_instance.errors %>, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
        redirect_to <%= plural_table_name %>_url, notice: t('messages.update.notice', :model => "<%= singular_table_name.capitalize %>")
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @<%= orm_instance.destroy %>
        format.html { redirect_to <%= index_helper %>_url, notice: t('messages.destroy.notice', :model => "<%= singular_table_name.capitalize %>")}
      else
        format.html { redirect_to <%= index_helper %>_url, alert: @<%= orm_instance.errors.full_messages[0] %> }
        format.json { head :no_content }
       end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
