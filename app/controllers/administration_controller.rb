class AdministrationController < ApplicationController
  authorize_admin!
  layout "fullwidth"

  def clear_caches
    Rails.cache.delete('Talk.all')
    Rails.cache.delete('Talk.approved')
    Rails.cache.delete('Talk.talk_type_count')
    Rails.cache.delete('Sponsor.all')

    flash[:notice] = 'Caches cleared.'
    redirect_to :action => 'caches'
  end

end
