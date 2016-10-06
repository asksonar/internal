class Airsonar
  include HTTParty
  base_uri 'webservices-env.m4edbzxi9e.us-west-2.elasticbeanstalk.com'
  raise_on (400..599).to_a

  def initialize()
    @options = {
      headers: {
        "Content-Type" => "application/json",
        "Authorization" => Rails.application.secrets.airsonar_api_key
      }
    }
  end

  def get_resolutions
    self.class.get("/resolutionSvc/queue/", @options).parsed_response
  end

  def get_resolution(id)
    self.class.get("/resolutionSvc/queue/#{id}", @options).parsed_response
  end

  def apply_resolution(id, options)
    options = @options.merge({ body: options.to_json })
    self.class.post("/resolutionSvc/queue/#{id}", options)
  end

  def reject_resolution(id)
    self.class.delete("/resolutionSvc/queue/#{id}", @options)
  end
end
