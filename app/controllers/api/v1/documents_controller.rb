class Api::V1::DocumentsController < Api::V1::ApiController
  before_action :set_document, only: [:validation]

  layout 'api'

  def validation
    unless @document.present?
      redirect_to '/404'
    end
  end

private
 
   def set_document
     @document = Document.find_by(autentication: params[:autentication])
   end

end
