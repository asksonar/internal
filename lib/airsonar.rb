class Airsonar
  include HTTParty
  base_uri 'webservices-env.m4edbzxi9e.us-west-2.elasticbeanstalk.com'

  def initialize()
    @options = {
      headers: {
        "Content-Type" => "application/json"
      }
    }
  end

  def getResolutionQueue
    self.class.get("/resolutionSvc/queue/").parsed_response
  end

  def getResolution(id)
    self.class.get("/resolutionSvc/queue/#{id}").parsed_response
  end

  def applyResolution(id, options)
    options = @options.merge({ body: options.to_json })
    self.class.post("/resolutionSvc/queue/#{id}", options)
  end

  def rejectResolution(id)
    self.class.delete("/resolutionSvc/queue/#{id}")
  end
end
