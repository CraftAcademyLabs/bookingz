module ApplicationHelper

  def callout(key)
    case key
      when 'success' then
        'success'
      when 'warning' then
        'warning'
      when 'alert' then
        'alert'
      else
        'primary'
    end
  end

  def application_name
    Settings.app_name
  end

  def copyright_message
    Settings.copyright_message
  end

  def markdown_parser(file)
    file_to_open = File.open(file)

    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

     renderer = Redcarpet::Render::HTML.new(options)
     markdown = Redcarpet::Markdown.new(renderer, extensions = {})

    markdown.render(file_to_open.read).html_safe
  end

  def facilities_select_options
    Facility.all.collect {|f| [ f[:name], f[:id] ] }
  end

end
