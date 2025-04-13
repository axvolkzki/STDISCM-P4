class ViewgradesController < ApplicationController
  def student_grades
    begin
      jwt_token = cookies["jwt_token"]
      @response = Faraday.get(ENV["VIEW_GRADES_IP"], nil, {Authorization: "Bearer #{jwt_token}"})

      @data = JSON.parse(@response.body)
    rescue Faraday::ConnectionFailed => e
      @err = e
    end
  end
end
