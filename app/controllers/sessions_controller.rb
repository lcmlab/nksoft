# coding: utf-8

class SessionsController < ApplicationController

  layout "nksoft"


  def create

#debugger # << app/controllers/sessions_controller.rb def create(1)

    employee = Employee.authenticate(params[:username], params[:password])
    if employee
      session[:employee_id] = employee.id
    else
      flash.alert = "名前とパスワードが一致しません"
    end
    redirect_to params[:from] || :root
  end

  def destroy
    session.delete(:employee_id)
    redirect_to :root
  end

end
