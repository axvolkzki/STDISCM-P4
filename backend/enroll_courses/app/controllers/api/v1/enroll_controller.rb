module Api
    module V1
        class EnrollController < ApplicationController
            before_action :authorized

            def index 
                # enroll a student using the course id and user id
                @enrolled_courses = EnrolledCourse
                    .joins('INNER JOIN "courses" ON "courses".id = "enrolled_courses".courses_id')
                    .joins('INNER JOIN "users" ON "users".id = "enrolled_courses".users_id')
                    .select("enrolled_courses.*, users.*, courses.*")
                    .order("enrolled_courses.id DESC")

                render json: @enrolled_courses
            end

            def view
                courses = Course.all
                render json: courses
            end

            def create
                user = current_user
                course_id = params[:course_id]
              
                # Validate
                course = Course.find_by(id: course_id)
                return render json: { message: 'Course not found' }, status: :not_found if course.nil?
              
                if course.numStudents >= course.maxStudents
                  return render json: { message: 'Course is full' }, status: :unprocessable_entity
                end
              
                already_enrolled = EnrolledCourse.exists?(users_id: user.id, courses_id: course.id)
                if already_enrolled
                  return render json: { message: 'Already enrolled' }, status: :conflict
                end
              
                # Save to enrolled_courses table!
                enrollment = EnrolledCourse.create(users_id: user.id, courses_id: course.id)
                course.increment!(:numStudents)
              
                render json: { message: 'Enrolled successfully', course: course }, status: :created
            end
              

            # GET /api/v1/courses/search?code=STDISCM
            def search
                if params[:code].present?
                code = params[:code].upcase.strip
                courses = Course.where('UPPER(code) = ?', code)
            
                if courses.any?
                    render json: courses, status: :ok
                else
                    render json: { message: 'No courses found' }, status: :not_found
                end
                else
                render json: { error: "Missing 'code' query parameter" }, status: :bad_request
                end
            end
            # def search
            #     if params[:code].present?
            #         code = params[:code].upcase.strip
            #         courses = Course.where('UPPER(code) = ?', code)

            #         # ensure that the id of each course is included in the response
            #         courses = courses.map do |course|
            #             course.as_json.merge(id: course.id) # Add the id to the course JSON representation
            #             render json: courses, status: :ok
            #     end

            #     if courses.empty?
            #         render json: { message: 'No courses found' }, status: :not_found
            #     else

                
            #     else
            #     render json: { error: "Missing 'code' query parameter" }, status: :bad_request
            #     end
            # end

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