class Admin::SiteSettingsController < AdminController

  def edit
    @site_setting = SiteSetting.first_or_initialize
  end

  def update
    @site_setting = SiteSetting.first_or_initialize
    if @site_setting.update(site_settings_params)
      flash[:notice] = 'Changes saved'
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def site_settings_params
    params.require(:site_setting).permit(
      :site_name,
      :maximum_event_attendees
    )
  end
end