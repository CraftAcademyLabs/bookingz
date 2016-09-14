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
    @file = File.open('app/views/markdown/instructions.md')

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

    markdown.render(@file.read).html_safe
  end

end
