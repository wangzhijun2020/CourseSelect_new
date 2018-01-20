class GradesController < ApplicationController

before_action :teacher_logged_in, only: [:update]

def update
  @grade=Grade.find_by_id(params[:id])
  if @grade.update_attributes!(:grade => params[:grade][:grade])
    flash={:success => "#{@grade.user.name} #{@grade.course.name}的成绩已成功修改为 #{@grade.grade}"}
  else
    flash={:danger => "上传失败.请重试"}
  end
  redirect_to grades_path(course_id: params[:course_id]), flash: flash
end

def index
  if teacher_logged_in?
    @course=Course.find_by_id(params[:course_id])
    @grades=@course.grades
  elsif student_logged_in?
    @grades=current_user.grades
  else
    redirect_to root_path, flash: {:warning=>"请先登陆"}
  end
end
def degree
  if teacher_logged_in?
    @course=Course.find_by_id(params[:course_id])
    @grades=@course.grades
  elsif student_logged_in?
    @grades=current_user.grades
  else
    redirect_to root_path, flash: {:warning=>"请先登陆"}
  end
end
def degree1
  @grade=Grade.find_by_id(params[:id])
  @grade.update_attributes(:degree=>true)
  redirect_to grades_degree_path, flash: {:success => "已经成功设置#{ @grade.course.name}为学位课！"}
end
def degree0
  @grade=Grade.find_by_id(params[:id])
  @grade.update_attributes(:degree=>false)
  redirect_to grades_degree_path, flash: {:success => "已经成功设置#{ @grade.course.name}为非学位课！"}
end

def import
  file = params[:file]
  begin
    file_ext = File.extname(file.original_filename)
    if not [".xls", ".xlsx"].include?(file_ext)
      flash={:danger => "失败，文件类型不支持"}
    else
      spreadsheet = (file_ext == ".xls") ? Roo::Excel.new(file.path) : Roo::Excelx.new(file.path)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        @grade=Grade.find_by_id(spreadsheet.row(i)[0])
        @grade.update_attributes!(:grade => spreadsheet.row(i)[4])
      end
      flash={:success => "上传成功"}
    end
    redirect_to grades_path(course_id: params[:course_id]), flash: flash
  end
end



def export
  if teacher_logged_in?
    @course=Course.find_by_id(params[:course_id])
    @grades=@course.grades
  else
    redirect_to root_path, flash: {:warning=>"请先登陆"}
  end
  
  respond_to do |format|
    format.html
    format.xls {
      require 'spreadsheet'
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet
      sheet1.row(0).concat %w{成绩id 学号 姓名 专业 成绩}
      @grades.each_with_index do |grade,i|
        sheet1.row(i+1).push grade.id, grade.user.num, grade.user.name, grade.user.major, grade.grade
      end
      book.write 'grade.xls'
      send_file 'grade.xls',:type => "application/vnd.ms-excel", :filename => "#{@course.name}.xls", :stream => false
      return
    }
  end
end

private

# Confirms a teacher logged-in user.
def teacher_logged_in
  unless teacher_logged_in?
    redirect_to root_url, flash: {danger: '请登陆'}
  end
end
end
