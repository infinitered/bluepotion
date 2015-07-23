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

    # the string value all up inside your 'res/values/strings.xml' (or nil)
    def string(name=nil)
      return nil unless name
      resource_id = find(:string, name)
      return nil if resource_id.nil? || resource_id == 0
      PMApplication.current_application.resources.getString(resource_id)
    end
  end
end
