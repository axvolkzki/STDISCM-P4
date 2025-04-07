Rails.application.routes.draw do
    # GET /login
    get "/", to: "login#login"
  
    # GET /studentdashboard
    get "/studentdashboard", to: "studentdashboard#dashboard"

    # GET /searchcourse
    get "/searchcourse", to: "searchcourse#search"
  
    # GET /viewcourse
    get "/viewcourse", to: "viewcourse#course"

    # GET /enrolldashboard
    get "/enrolldashboard", to: "enrolldashboard#dashboard"

    # GET /addclass
    get "/addclass", to:"addclass#class"
  
    # GET /enrollcourse
    get "/enrollcourse", to:"enrollcourse#enroll"

    # GET /enrollsummary
    get "/enrollsummary", to:"enrollsummary#summary"

    # GET /dropcourse
    get "/dropcourse", to:"dropcourse#drop"
  
    # GET /viewgrades
    get "/student_viewgrades", to:"viewgrades#student_grades"
  
    # GET /facultydashboard
    get "/facultydashboard", to: "facultydashboard#dashboard"
  
    # GET /addgrades
    get "/addgrades", to: "addgrades#addgrades"
end
