require 'test_helper'

class TestVenue
  attr_reader :messages

  def initialize
    @messages = []
  end

  def register(message)
    @messages << message
  end
end

class AnnouncerTest < Test::Unit::TestCase
  context "When a new Campaign is launched for a service, the campaign" do
    setup do
      @service_name = "ShinyApp"
      @venue = TestVenue.new
      @campaign = Adman::Campaign.new(@service_name).add_venue(@venue).launch
    end

    should "deliver the right message about the right service" do
      assert_equal @campaign.message, Adman::Service.new(@service_name)
    end

    should "deliver the message to each venue" do
      assert @campaign.venues.include?(@venue)
      @campaign.venues.each do |venue|
        assert venue.messages.include?(@campaign.message)
      end
    end
  end

  context "When a new Service is created from just a String, it" do
    setup do
      @service_name = "ShinyApp"
      @service = Adman::Service.new(@service_name)
    end

    should "use the String as the service name" do
      assert_equal @service.name, @service_name
    end

    should "use the default port (#{Adman::Service::DEFAULT_PORT})" do
      assert_equal @service.port, Adman::Service::DEFAULT_PORT
    end

    should "use the default service type (#{Adman::Service::DEFAULT_TYPE})" do
      assert_equal @service.type, Adman::Service::DEFAULT_TYPE
    end
  end
end
