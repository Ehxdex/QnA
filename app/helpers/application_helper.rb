module ApplicationHelper
  def prepend_flash
    turbo_stream.prepend "flash", partial: "shared/flash"
  end

  def flash_class(flash_type)
    case flash_type.to_sym
    when :success
      "alert-success"
    when :error, :alert, :danger
      "alert-danger"
    when :notice
      "alert-info"
    else
      "alert-warning"
    end
  end
end
