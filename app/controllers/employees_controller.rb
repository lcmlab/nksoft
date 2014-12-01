# coding: utf-8

class EmployeesController < ApplicationController
  before_filter :login_required

  layout "nksoft"


  def index
#debugger # employees_controller def index
    @department = Department.find(session[:department_id])
    @employees = @department.employees.order('id DESC')
#debugger # employees_controller def index
  end

  def edit
    @states = State.all
    @employee = Employee.find(params[:id])
#debugger # employees_controller def edit
  end

  def update
    @employee = Employee.find(params[:id])

#debugger # employees_controller def update

    if @employee.update_attributes(params[:employee])
       redirect_to :action => 'index'
    else
       @states = State.all
       render 'edit'
    end
  end

end
