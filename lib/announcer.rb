module Announcer

  # Indicates this service is a web application
  WEB_APPLICATION = "_web_app"

  class Announcer

    attr_reader :service

    def initialize(service_name)
      @service = Service.new(service_name)
    end

  end

  class Service
    attr_reader :name
    attr_reader :port
    attr_reader :type

    def initialize(service_name)
      @name = service_name

      # Set some defaults
      @port = 3000
      @type = WEB_APPLICATION
    end
  end

  def self.announce(service_name)
    announcer = Announcer.new(service_name)
    announcer
  end

end
