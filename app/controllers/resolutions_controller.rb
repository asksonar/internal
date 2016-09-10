class ResolutionsController < ApplicationController
  # before_action :authenticate_user!

  def index
    response = Airsonar.new.getResolutionQueue
    @resolutions = response['change_items']
  end

  def show
    @resolution_id = params[:id]
    response = Airsonar.new.getResolution(@resolution_id)
    merge_data = response['merge_data']
    updates = response['updates']

    if !updates['aircraft_history'].nil?
      @update_type = 'aircraft_history'
      @existing_data = merge_data['aircraft_history']
      @new_data = updates['aircraft_history']
    else
      @update_type = 'aircraft'
      @existing_data = merge_data['aircraft']
      @new_data = updates['aircraft']
    end
  end
end
