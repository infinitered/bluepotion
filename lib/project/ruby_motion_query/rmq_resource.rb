class RMQ
  # @return [RMQResource]
  def self.resource
    RMQResource
  end

  # @return [RMQResource]
  def resource
    RMQResource
  end
end

class RMQResource
  class << self
    def find(resource_type, resource_name)
      application = PMApplication.current_application
      application.resources.getIdentifier(resource_name.to_s,
                                          resource_type.to_s,
                                          application.package_name)
    end

    def layout(name)
      self.find("layout", name)
    end
  end
end
