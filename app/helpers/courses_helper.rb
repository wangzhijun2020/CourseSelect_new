require 'set'

module CoursesHelper
  def week_data_to_num(week_data)
    param = {
        '周一' => 0,
        '周二' => 1,
        '周三' => 2,
        '周四' => 3,
        '周五' => 4,
        '周六' => 5,
        '周天' => 6,
    }
    param[week_data] + 1
  end


  def get_course_table(courses)
    course_time = Array.new(11) { Array.new(7, {'name' => '', 'id' => '', 'room' => ''}) }
    if courses
      courses.each do |cur|
        cur_time = String(cur.course_time)
        end_j = cur_time.index('(')
        j = week_data_to_num(cur_time[0...end_j])
        t = cur_time[end_j + 1...cur_time.index(')')].split("-")
        for i in (t[0].to_i..t[1].to_i).each
          course_time[(i-1)*7/7][j-1] = {
              'name' => cur.name,
              'id' => cur.id,
              'room' => cur.class_room
          }
        end
      end
    end
    course_time
  end

  def get_student_course()
    course = []
    current_user.grades.each do |x|
      course << x.course
    end
    course
  end

  def isopen?()
    Opensystem.find_by_id(1).isopen
  end

end