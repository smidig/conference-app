module ApplicationHelper
  def asset_url asset
    "#{request.protocol}#{request.host_with_port}#{asset_path(asset)}"
  end

  def setting_for(key, default_value = nil)
    setting = Setting.setting_for(key)

    if setting
      setting.val
    else
      default_value
    end
  end

  def name_for_controller
    controller_name.singularize.humanize.downcase
  end

  def boolean_value(val)
    content_tag(
        :a,
        content_tag(:i, "", class: "icon-#{val ? 'check' : 'ban-circle'}"),
        class: "btn btn-xs #{val ? 'btn-info' : 'btn-danger'} disabled")
  end
end
