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
      @merge_data = merge_data['aircraft_history']
      @new_data = updates['aircraft_history']
    else
      @update_type = 'aircraft'
      @merge_data = merge_data['aircraft']
      @new_data = updates['aircraft']
    end
  end

  def update
    airsonar = Airsonar.new()
    approved_updates = updates.select { |key, value| value == 'approve' }.keys
    rejected_updates = updates.select { |key, value| value == 'reject' }.keys

    if approved_updates.empty?
      response = airsonar.rejectResolution(params[:id])
    else
      options = Hash.new { |h,k| h[k] = Hash.new(&h.default_proc) }

      if approved_updates.present? && rejected_updates.present?
        merge_data.each do |key, value|
          options[:merge_data][update_type][key] = value
        end

        approved_updates.each do |key, value|
          options[:updates][update_type][key] = new_data[key]
        end
      end

      response = airsonar.applyResolution(params[:id], options)
    end

    redirect_to resolutions_path
  end

  private

  def merge_data
    update_params[:merge_data]
  end

  def new_data
    update_params[:new_data]
  end

  def updates
    update_params[:updates]
  end

  def update_type
    update_params[:update_type]
  end

  def update_params
    params.require(:resolutions).permit(
      :update_type,
      :merge_data => [
        :id, :model, :msn, :delivery_date, :aircraft_status, :aircraft_type, :registration,
        :engine_model, :engine_variant,:operator, :build_year, :aircraft_age, :line_number
      ],
      :new_data => [
        :aircraft_status, :aircraft_type, :registration, :engine_model, :engine_variant,
        :operator, :build_year, :aircraft_age, :line_number
      ],
      :updates => [
        :aircraft_status, :aircraft_type, :registration, :engine_model, :engine_variant,
        :operator, :build_year, :aircraft_age, :line_number
      ]
    )
  end
end
