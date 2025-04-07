class CourseSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :max_students, :num_students, :section, :department_id

  def max_students
    object.maxStudents
  end

  def num_students
    object.numStudents
  end

  def section
    object.section
  end

  def department_id
    object.department_id
  end
end