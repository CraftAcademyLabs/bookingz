module DeviseHelper
  def devise_error_messages!
    content = ''
    if resource.errors.full_messages.any?
      resource.errors.full_messages.each do |message|
        content << javascript_tag("Materialize.toast(\"#{message}\", 8000)")
      end
    end
    content.html_safe
  end

end