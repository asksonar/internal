require 'airsonar'

class ResolutionsService
  include Singleton
  attr_reader :airsonar

  def initialize
    @airsonar = Airsonar.new()
  end

  def get_resolutions
    response = airsonar.get_resolutions
    response['change_items']
  end

  def get_resolution(id)
    airsonar.get_resolution(id)
  end

  def reject_resolution(id)
    airsonar.reject_resolution(id)
  end

  def apply_resolution(id, options)
    airsonar.apply_resolution(id, options)
  end
end
