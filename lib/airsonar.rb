class Airsonar
  include HTTParty
  # base_uri 'http://webservices-env.m4edbzxi9e.us-west-2.elasticbeanstalk.com'

  def getResolutionQueue
    resolutions = HTTParty.get('http://webservices-env.m4edbzxi9e.us-west-2.elasticbeanstalk.com/resolutionSvc/queue/').parsed_response
  end

  def getResolution(id)
    resolution = HTTParty.get('http://webservices-env.m4edbzxi9e.us-west-2.elasticbeanstalk.com/resolutionSvc/queue/' + id).parsed_response
  end
end
