require 'test_helper'

class AnnouncerTest < Test::Unit::TestCase
  context "When an Announcer announces a service, it" do
    setup do
      @service_name = "My really cool webapp"
      @announcer = Announcer::announce(@service_name)
#      @announcer = Announcer::announce do |announcer|
#        announcer.service(@service_name)
#      end
    end

    should "announce the service to the network" do
      assert_equal @announcer.service.name, @service_name
    end

    should "default to announcing the service on port 3000" do
      assert_equal @announcer.service.port, 3000
    end

    should "default to announcing a web site" do
      assert_equal @announcer.service.type, Announcer::WEB_APPLICATION
    end
  end
end
