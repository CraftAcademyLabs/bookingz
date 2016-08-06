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
end
