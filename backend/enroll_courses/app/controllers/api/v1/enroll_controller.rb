module Api
    module V1
        class EnrollController < ApplicationController
            before_action :authorized
            
            def enroll 
                course = Course.find_by(code: params[:code])

                # Check if the course exists
                if course.nil?
                    render json: { error: 'Course not found' }, status: :not_found
                    return
                end

                # Check if the user is already enrolled in the course
                if EnrolledCourse.exists?(user_id: current_user.id, course_id: course.id)
                    render json: { error: 'Already enrolled in this course' }, status: :conflict
                    return
                end

                # Check if the course is full
                if course.numStudents >= course.maxStudents
                    render json: { error: 'Course is full' }, status: :conflict
                    return
                end

                # Enroll the user in the course
                enrolled_course = EnrolledCourse.new(user_id: current_user.id, course_id: course.id)
                if enrolled_course.save
                    # Update the course's numStudents
                    course.increment!(:numStudents)
                    render json: { message: 'Successfully enrolled in the course' }, status: :created   
                else
                    render json: { error: 'Failed to enroll in the course' }, status: :unprocessable_entity
                end
            end


            def decoded_token
                token = request.headers['Authorization']&.split(' ')&.last
                return unless token
      
                JwtService.decode(token) # Reuse your JWT service
            rescue JWT::DecodeError
                nil
            end
      
            def current_user
                if decoded_token
                    user_id = decoded_token['user_id']
                    @user = User.find_by(id: user_id)
                end
            end
      
            def authorized
              unless !!current_user
                render json: { message: 'Please log in' }, status: :unauthorized    
              end
            end
        end
    end
end