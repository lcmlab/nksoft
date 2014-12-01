# coding: utf-8

class Admin::ProjectsController < Admin::Base

  layout "nksoft"


  # プロジェクト一覧
   def index
      @projects = Project.order("id").
        paginate(page: params[:page], per_page: 15)
   end

  # 検索
   def search
      @projects = Project.search(params[:q]).
        paginate(page: params[:page], per_page: 15)
      render "index"
   end

  # プロジェクト情報の詳細
   def show
#debugger #<< admin projects_controller def show(1)  <<<<<<
      @project = Project.find(params[:id])
   end

  # 新規作成フォーム
   def new
      @clients = Client.all
      @project = Project.new
      @splittimes = Splittime.all
   end

  # 更新フォーム
   def edit
      @clients = Client.all
      @splittimes = Splittime.all
      @project = Project.find(params[:id])
   end

  # プロジェクトの新規登録
   def create
      @project = Project.new(params[:project])
      if @project.save
         redirect_to [:admin, @project], notice: "プロジェクトを登録しました。"
      else
         render "new"
      end
   end

  # プロジェクト情報の更新
   def update
      @project = Project.find(params[:id])
      @project.assign_attributes(params[:project])
      if @project.save
         redirect_to [:admin, @project], notice: "プロジェクト情報を更新しました。"
      else
         render "edit"
      end
   end

  # プロジェクトの削除
   def destroy
      @project = Project.find(params[:id])
      @project.destroy
      redirect_to :admin_projects, notice: "プロジェクトを削除しました。"
   end

end
