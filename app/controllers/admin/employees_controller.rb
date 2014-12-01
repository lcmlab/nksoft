# coding: utf-8

class Admin::EmployeesController < Admin::Base
  #before_filter :login_required

  layout "nksoft"


  # 勤務者一覧
  def index
    @employees = Employee.order('id DESC').
        paginate(page: params[:page], per_page: 10)

#debugger # << admin/employees_controller def index(1)
  end


  # 検索
   def search
      @employees = Employee.search(params[:q]).
      paginate(page: params[:page], per_page: 10)
      render "index"
   end

  # 勤務者情報の詳細
  def show
    @employee = Employee.find(params[:id])
  end

  # 新規作成フォーム
  def new
    @departments = Department.all
    @states = State.all
    @employee = Employee.new
  end

  # 勤務者の新規登録
  def create
    @employee = Employee.new(params[:employee], as: :admin)
    if @employee.save
       redirect_to [:admin, @employee], notice: "勤務者を登録しました。"
    else
       render "new"
    end
  end

  # 更新フォーム
  def edit
    @departments = Department.all
    @states = State.all
    @employee = Employee.find(params[:id])
#debugger # << admin/employees_controller def edit(1)
  end

  # 勤務者情報の更新
  def update
    @employee = Employee.find(params[:id])
    #@employee = Employee.find(params[:id], as: :admin)

#debugger # << admin/employees_controller def update(1)

    @employee.assign_attributes(params[:employee])
    if @employee.update_attributes(params[:employee])
       #redirect_to :action => 'index'
       redirect_to [:admin, @employee], notice: "勤務者の情報を更新しました。"
    else
       @states = State.all
       render 'edit'
    end
  end

  # 勤務者の削除
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to :admin_employees, notice: "勤務者を削除しました。"
  end

end
