class SettingsController < ApplicationController
  authorize_admin!
  layout "fullwidth"

  def index
    @settings = Setting.all
  end

  def update
    setting = Setting.find(params[:id])

    val = params[:setting][:val]

    if setting.setting_type == 'boolean'
      val = (val == '1')
    end

    setting.val = val

    if setting.save
      update_based_on_key(setting)
      redirect_to settings_url
    else
      render :index
    end
  end

  private

  def update_based_on_key(setting)
    if setting.key == "early-bird-available"
      Ticket.toggle_early_bird(setting.val)
    end
  end
end
