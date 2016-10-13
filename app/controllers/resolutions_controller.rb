class ResolutionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @resolutions = api.get_resolutions
  end

  def show
    @resolution_id = params[:id]
    response = api.get_resolution(@resolution_id)

    @resolution_type = response['action']
    @user_comment = response['user_comment']
    merge_data = response.fetch('merge_data', {})
    updates = response.fetch('updates', {})

    if @resolution_type == 'POST' || @resolution_type == 'PATCH'
      @update_type = updates.keys.include?('aircraft_history') ? 'aircraft_history' : 'aircraft'
    elsif @resolution_type == 'DELETE'
      @update_type = merge_data.keys.include?('aircraft_history') ? 'aircraft_history' : 'aircraft'
    end

    @new_data = updates.fetch(@update_type, {})
    @merge_data = merge_data.fetch(@update_type, {})
  end

  def update
    approved_updates = updates.select { |key, value| value == 'approve' }.keys
    rejected_updates = updates.select { |key, value| value == 'reject' }.keys

    if approved_updates.empty?
      api.reject_resolution(params[:id])
      flash[:info] = '<strong>Resolution successfully rejected</strong>'
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

      api.apply_resolution(params[:id], options)
      flash[:info] = '<strong>Resolution successfully merged</strong>'
    end

    redirect_to resolutions_path
  end

  private

  def merge_data
    update_params[:merge_data] || {}
  end

  def new_data
    update_params[:new_data] || {}
  end

  def updates
    update_params[:updates] || {}
  end

  def update_type
    update_params[:update_type]
  end

  def update_params
    params.require(:resolutions).permit(
      :update_type,
      :merge_data => [
        :id, :model, :msn, :delivery_date, :aircraft_status, :aircraft_type, :registration,
        :engine_model, :engine_variant, :operator, :operator_name, :build_year, :aircraft_age,
        :line_number, :delete_aircraft_history, :engine_name, :seats_configuration
      ],
      :new_data => [
        :aircraft_status, :aircraft_type, :registration, :engine_model, :engine_variant,
        :operator, :operator_name, :build_year, :aircraft_age, :line_number, :delete_aircraft_history,
        :delivery_date, :engine_name, :seats_configuration
      ],
      :updates => [
        :aircraft_status, :aircraft_type, :registration, :engine_model, :engine_variant,
        :operator, :operator_name, :build_year, :aircraft_age, :line_number, :delete_aircraft_history,
        :delivery_date, :engine_name, :seats_configuration
      ],
    )
  end

  private

  def api
    @api ||= ResolutionsService.instance
  end
end
