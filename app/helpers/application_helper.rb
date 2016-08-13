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
end
