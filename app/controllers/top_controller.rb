# coding: utf-8

class TopController < ApplicationController
  def index
#debugger # << app/controllers/top_controller.rb def index(1)
    @department = Department.find(1)
    @employees = @department.employees.order('id DESC')
  end
end
