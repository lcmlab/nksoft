# coding: utf-8

class Admin::DepartmentsController < Admin::Base
  #before_filter :login_required

  layout "nksoft"


  # 所属部門一覧
   def index
      @departments = Department.
        paginate(page: params[:page], per_page: 10)
   end

  # 検索
   def search
      @departments = Department.search(params[:q]).
        paginate(page: params[:page], per_page: 10)
      render "index"
   end

  # 所属部門情報の詳細
   def show
#debugger #<< admin departments_controller def show(1)  <<<<<<
      @department = Department.find(params[:id])
   end

  # 新規作成フォーム
   def new
      @department = Department.new
   end

  # 更新フォーム
   def edit
      @department = Department.find(params[:id])
   end

  # 所属部門の新規登録
   def create
      @department = Department.new(params[:department])
      if @department.save
         redirect_to [:admin, @department], notice: "所属部門を登録しました。"
      else
         render "new"
      end
   end

  # 所属部門情報の更新
   def update
      @department = Department.find(params[:id])
      @department.assign_attributes(params[:department])
      if @department.save
         redirect_to [:admin, @department], notice: "所属部門情報を更新しました。"
      else
         render "edit"
      end
   end

  # 所属部門の削除
   def destroy
      @department = Department.find(params[:id])
      @department.destroy
      redirect_to :admin_departments, notice: "所属部門を削除しました。"
   end

end
