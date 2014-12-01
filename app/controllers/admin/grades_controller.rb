# coding: utf-8

class Admin::GradesController < Admin::Base



  layout "nksoft"


  # 職能作業名称一覧
   def index
      @grades = Grade.order("id").
        paginate(page: params[:page], per_page: 10)
   end

  # 検索
   def search
      @grades = Grade.search(params[:q]).
        paginate(page: params[:page], per_page: 10)
      render "index"
   end

  # 職能作業名称情報の詳細
   def show
#debugger #<< admin grades_controller def show(1)  <<<<<<
      @grade = Grade.find(params[:id])
   end

  # 新規作成フォーム
   def new
      @grade = Grade.new
   end

  # 更新フォーム
   def edit
      @grade = Grade.find(params[:id])
   end

  # 職能作業名称の新規登録
   def create
      @grade = Grade.new(params[:grade])
      if @grade.save
         redirect_to [:admin, @grade], notice: "職能作業名称を登録しました。"
      else
         render "new"
      end
   end

  # 職能作業名称情報の更新
   def update
      @grade = Grade.find(params[:id])
      @grade.assign_attributes(params[:grade])
      if @grade.save
         redirect_to [:admin, @grade], notice: "職能作業名称情報を更新しました。"
      else
         render "edit"
      end
   end

  # 職能作業名称の削除
   def destroy
      @grade = Grade.find(params[:id])
      @grade.destroy
      redirect_to :admin_grades, notice: "職能作業名称を削除しました。"
   end




end
