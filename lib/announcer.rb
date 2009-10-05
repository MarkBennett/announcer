module Adman

  # Indicates this service is a web application
  WEB_APPLICATION = "_web_app"

  # Announces services on a network or other venue.
  class Campaign

    attr_reader :message
    attr_reader :venues

    # Create a new Campaign to advertize the given service.
    #
    # If the service given isn't already a Service (a String perhaps?) then the
    # Campaign will try to turn it into one.
    def initialize(service)
      # If this isn't yet a service try to turn it into one
      unless service.kind_of?(Service)
        service = Service.new(service)
      end
      @message = service

      @venues = []
    end

    def add_venue(venue)
      @venues << venue
      self
    end

    # Start advertising this service
    def launch
      @venues.each do |venue|
        venue.register(message)
      end
      self
    end
  end

  # A Service which is announced by the announcer.
  #
  # A service is a general term and can be a web application,
  # mail server, or anything that can described in terms of a
  # service name, type, and port.
  class Service

    DEFAULT_PORT = 3000
    DEFAULT_TYPE = "_web_app"

    include Comparable

    attr_reader :name
    attr_reader :port
    attr_reader :type

    # Compare this Service to another
    def <=>(other)
      if self.name < other.name
        return -1
      elsif self.name > other.name
        return 1
      elsif self.port < other.port
        return -1
      elsif self.port > other.port
        return 1
      elsif self.type < other.type
        return -1
      elsif self.type > other.type
        return 1
      else
        return 0
      end
    end

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
