module QuickSetHelper

  def tooltip(quickset)
    return unless quickset and quickset.content_providers.size > 0

    tooltip = ''
    quickset.content_providers.each do |db|
      tooltip += db.name
    end

    tooltip
  end

  def quickset_popover_data_options(quickset)
    return unless quickset and quickset.content_providers.size > 0

    data_options = {
      title:     quickset.name,
      toggle:    'popover',
      trigger:   'hover',
      # trigger:   'click',
      html:      'true',
      placement: 'top',
      content:   popover_content(quickset)
    }

    return data_options
  end


  def popover_content(quickset)
    return unless quickset && quickset.content_providers.size > 0

    popover_content = "<b>Set contains #{quickset.content_providers.size} databases</b>"

    popover_content += "<ul class='quickset_database'>"
    quickset.content_providers.each do |db|
      popover_content += "<li>#{db.name}</li>"
    end
    popover_content += "</ul>"

    popover_content.html_safe
  end


  # This is to be used on the Scoped Search screens.
  # They will have no default.
  def eds_fielded_dropdown(fieldname = 'search_field', default_value = nil)
    options = DATASOURCES_CONFIG['datasources']['eds']['search_box'] || {}

    if options['search_fields'].kind_of?(Hash)
      return dropdown_with_select_tag(fieldname, options['search_fields'].invert, default_value)
    end
  end

  def quickset_length_notice(quickset)
    cp_length = quickset.content_provider_byte_length

    # "color" being a bootstrap class name
    notice_color = 'default'
    notice_color = 'warning' if cp_length > 1800
    notice_color = 'danger'  if cp_length > 2000

    notice = "<p class='quickset_notice alert alert-#{notice_color}'>" +
      "character count: #{cp_length}</p>"

    return notice.html_safe
  end
end
