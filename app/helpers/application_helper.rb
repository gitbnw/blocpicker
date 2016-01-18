module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def bootstrap_icon_for flash_type
    { success: "ok-circle", error: "remove-circle", alert: "warning-sign", notice: "exclamation-sign" }[flash_type.to_sym] || "question-sign"
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in text-center") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message + " "
              concat content_tag(:i, nil, class: "glyphicon glyphicon-#{bootstrap_icon_for(msg_type)}")
            end)
    end
    nil
  end
end
