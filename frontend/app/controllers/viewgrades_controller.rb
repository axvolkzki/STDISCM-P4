class ViewgradesController < ApplicationController
  def student_grades
    begin
      @response = Faraday.get(ENV["VIEW_GRADES_IP"])

      @data = JSON.parse(@response.body)
    rescue Faraday::ConnectionFailed => e
      @err = e
    end
  end
end
