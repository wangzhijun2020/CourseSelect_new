class CoursesController < ApplicationController
  include CoursesHelper
  before_action :student_logged_in, only: [:select, :quit, :list]
  before_action :teacher_logged_in, only: [:new, :create, :edit, :destroy, :update, :open, :close]#add open by qiao
  before_action :logged_in, only: :index

  #-------------------------for teachers----------------------

  def new
    @course=Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      current_user.teaching_courses<<@course
      redirect_to courses_path, flash: {success: "新课程申请成功"}
    else
      flash[:warning] = "信息填写有误,请重试"
      render 'new'
    end
  end

  def edit
    @course=Course.find_by_id(params[:id])
  end

  def update
    @course = Course.find_by_id(params[:id])
    if @course.update_attributes(course_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    redirect_to courses_path, flash: flash
  end

  def open
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: true)
    redirect_to courses_path, flash: {:success => "已经成功开启该课程:#{ @course.name}"}
  end

  def close
    @course=Course.find_by_id(params[:id])
    @course.update_attributes(open: false)
    redirect_to courses_path, flash: {:success => "已经成功关闭该课程:#{ @course.name}"}
  end

  def destroy
    @course=Course.find_by_id(params[:id])
    current_user.teaching_courses.delete(@course)
    @course.destroy
    flash={:success => "成功删除课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end

  #-------------------------for students----------------------

  def list
    #-------QiaoCode--------
    @isopen = isopen?()
    if @isopen
      @course=Course.where(:open=>true)
      @course=@course-current_user.courses
      @course_time_table = get_course_table(@course)
      tmp=[]
      @course.each do |course|
        if course.open==true
          tmp<<course
        end
      end
      @course=tmp
    end
  end

  def select
    @isopen = isopen?()
    if @isopen
    @flag=0
    @course=Course.find_by_id(params[:id])
    if !@course.limit_num.nil? 
      if @course.limit_num<=@course.student_num
        @flag=2
      end
    end
    @course_time_now=@course.course_time
    @course_week_now=@course.course_week
    if @course_week_now[2]=="-"
      @now_first_week=@course_week_now[1,1].to_i
    else
      @now_first_week=@course_week_now[1,2].to_i
    end
    if @course_week_now[-4]=="-"
      @now_last_week=@course_week_now[-3,1].to_i
    else
      @now_last_week=@course_week_now[-4,2].to_i
    end
    @now_weekday=@course_time_now[1,1]
    if @course_time_now[4]=="-"
      @now_first_time=@course_time_now[3,1].to_i
    else
      @now_first_time=@course_time_now[3,2].to_i
    end
    if @course_time_now[-3]=="-"
      @now_last_time=@course_time_now[-2,1].to_i
    else
      @now_last_time=@course_time_now[-3,2].to_i
    end
    @current_user_course=current_user.courses
    @tmp_course=@course
    @current_user_course.each do |course|    
      @course_week_user=course.course_week
      if @course_week_user[2]=="-"
        @user_first_week=@course_week_user[1,1].to_i
      else
        @user_first_week=@course_week_user[1,2].to_i
      end
      if @course_week_user[-4]=="-"
        @user_last_week=@course_week_user[-3,1].to_i
      else
        @user_last_week=@course_week_user[-4,2].to_i
      end
      @course_time_user=course.course_time
      @user_weekday=@course_time_user[1,1]
      if @user_first_week>@now_last_week or @user_last_week<@now_first_week or @user_weekday!=@now_weekday
         
      else
        if @course_time_user[4]=="-"
          @user_first_time=@course_time_user[3,1].to_i
        else
          @user_first_time=@course_time_user[3,2].to_i
        end
        if @course_time_user[-3]=="-"
          @user_last_time=@course_time_user[-2,1].to_i
        else
          @user_last_time=@course_time_user[-3,2].to_i
        end
        if @user_last_time<@now_first_time or @user_first_time>@now_last_time
           
        else
          @flag=1
          @tmp_course=course
          break
        end
      end
    end
    if @flag==0
      stu_num=@course.student_num+1
      @course.update_attributes(student_num:stu_num)
      current_user.courses<<@course
      flash={:suceess => "成功选择课程: #{@course.name}"}
      redirect_to courses_path, flash: flash
    elsif @flag==1
      flash={:fail =>"选课失败！ #{@course.name} 与 #{@tmp_course.name} 上课时间冲突！"}
      redirect_to courses_path, flash: flash
    else
      flash={:fail =>"选课失败！选课人数已达到上限！"}
      redirect_to courses_path, flash: flash
    end
  end
  end

  def quit
    @course=Course.find_by_id(params[:id])
    current_user.courses.delete(@course)
    stu_num=@course.student_num-1
    @course.update_attributes(student_num:stu_num)
    flash={:success => "成功退选课程: #{@course.name}"}
    redirect_to courses_path, flash: flash
  end


  #-------------------------for both teachers and students----------------------

  def index
    @isopen = isopen?()
    @course=current_user.teaching_courses if teacher_logged_in?
    @course=current_user.courses if student_logged_in?
    @course_time_table = get_course_table(@course)
  end


  private

  # Confirms a student logged-in user.
  def student_logged_in
    unless student_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a teacher logged-in user.
  def teacher_logged_in
    unless teacher_logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  # Confirms a  logged-in user.
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

  def course_params
    params.require(:course).permit(:course_code, :name, :course_type, :teaching_type, :exam_type,
                                   :credit, :limit_num, :class_room, :course_time, :course_week)
  end


end
