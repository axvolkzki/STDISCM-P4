class AddgradesController < ApplicationController
  def addgrades
    begin
      @response = Faraday.get(ENV["UPLOAD_GRADES_IP"])

      @data = JSON.parse(@response.body)
    rescue Faraday::ConnectionFailed => e
      @err = e
    end
  end
end
