module ApplicationHelper
  def sigla_sistema
    "DOC"
  end

  def nome_sistema
    "Document Generator"
  end

  def current_class?(path)
    if request.path.eql? path
      'active'
    else
      ''
    end
  end

  def error_messages_for(resource)
    render 'layouts/errors_messages', object: resource
  end

  def link_to_index(url, html_options= {})
    html_options.reverse_merge!(class: 'btn btn-default btn-xs', data: { tooltip: true, placement: 'top', animation: true }, title: t('helpers.links.index'))
    link_to t('helpers.links.cancel'), url, html_options
  end

  def link_to_edit(url, html_options= {})
    html_options.reverse_merge!(class: 'btn btn-default btn-xs', data: { tooltip: true, placement: 'top', animation: true }, title: t('helpers.links.edit'))
    link_to content_tag(:i, nil, class:'fa fa-edit fa-lg'), url, html_options
  end

  def link_to_new(url, html_options= {})
    html_options.reverse_merge!(class: 'btn btn-default btn-sm', data: { tooltip: true, placement: 'top', animation: true }, title: t('helpers.links.new'))
    link_to t('helpers.links.new'), url, html_options
  end

  def link_to_show(url, html_options= {})
    html_options.reverse_merge!(class: 'btn btn-default btn-xs', data: { tooltip: true, placement: 'top', animation: true }, title: t('helpers.links.show'))
    link_to content_tag(:i, nil, class:'fa fa-info-circle fa-lg'), url, html_options
  end

  def link_to_delete(url, html_options= {})
    html_options.reverse_merge!(method: :delete, class: 'btn btn-xs', data: { tooltip: true, confirm: t('messages.destroy.confirm'), placement: 'top', animation: true }, title: t('helpers.links.destroy'))
    link_to content_tag(:i, nil, class:'fa fa-trash fa-lg', style: 'color: red;'), url, html_options
  end

  def qrcode_image(filename, options = {})
    path = Rails.root.join("public/qrcodes/#{filename}")
    options[:src] = path.to_s
    attributes = options.map{ |k,v| "#{k}='#{v}'" }.join(" ")
    raw("<img #{attributes}/>")
  end
end
