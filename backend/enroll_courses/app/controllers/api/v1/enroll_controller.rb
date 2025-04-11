module Api
    module V1
        class EnrollController < ApplicationController
            before_action :authorized

            def index
                @enrolled_courses = EnrolledCourse
                    .joins('INNER JOIN "courses" ON "courses".id = "enrolled_courses".courses_id')
                    .joins('INNER JOIN "users" ON "users".id = "enrolled_courses".users_id')
                    .select("enrolled_courses.*, users.*, courses.*")
                    .where(users_id: @user.id)
                render json: @enrolled_courses
            end

            # POST /api/v1/enroll
            def enroll
                course = Course.find(params[:course_id])
                user = current_user

                if user.courses.include?(course)
                    render json: { message: 'Already enrolled in this course' }, status: :unprocessable_entity
                else
                    user.courses << course  # This will create an EnrolledCourse record
                    user.save
                    course.numStudents += 1 # Increment the number of students in the course
                    course.save
                    render json: { message: 'Successfully enrolled in the course' }, status: :ok
                end
            end

            private

            def authorized
                unless !!current_user
                    render json: { message: 'Please log in' }, status: :unauthorized    
                end
            end

            def current_user
                if decoded_token
                    user_id = decoded_token['user_id']
                    @user = User.find_by(id: user_id)
                end
            end

            def decoded_token
                token = request.headers['Authorization']&.split(' ')&.last
                return unless token

                JwtService.decode(token) # Reuse your JWT service
            rescue JWT::DecodeError
                nil
            end
        end
    end
end