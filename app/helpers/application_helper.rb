module ApplicationHelper
  FLASH_TO_BOOTSTRAP = {
    'success' =>'alert-success',
    'error' =>'alert-danger',
    'alert' =>'alert-warning',
    'notice' =>'alert-info'
  }

  def is_flash_alert(key)
    FLASH_TO_BOOTSTRAP.has_key? key
  end

  def flash_alert(key, value)
    class_name = FLASH_TO_BOOTSTRAP.fetch(key, "alert-#{key}")
    content_tag(:div, value, class: "flash-alert alert alert #{class_name}")
  end
end
