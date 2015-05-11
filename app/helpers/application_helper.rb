module ApplicationHelper
  def asset_url asset
    "#{request.protocol}#{request.host_with_port}#{asset_path(asset)}"
  end

  def setting_for key
    Setting.setting_for(key).val
  end
end
