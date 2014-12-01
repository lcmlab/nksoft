# coding: utf-8

class Admin::Base < ApplicationController
  before_filter :admin_login_required

  private
  def admin_login_required

#debugger # << app/controllers/admin/base.rb def admin_login_required(1)

    raise Forbidden unless @current_employee.try(:administrator?)
  end
end
