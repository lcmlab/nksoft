# coding: utf-8

class Admin::JobgroupsController < Admin::Base

  layout "nksoft"


  # 業務区分一覧
   def index
      @jobgroups = Jobgroup.order("id").
        paginate(page: params[:page], per_page: 15)
   end

  # 検索
   def search
      @jobgroups = Jobgroup.search(params[:q]).
        paginate(page: params[:page], per_page: 15)
      render "index"
   end

  # 業務区分情報の詳細
   def show
#debugger #<< admin jobgroups_controller def show(1)  <<<<<<
      @jobgroup = Jobgroup.find(params[:id])
   end

  # 新規作成フォーム
   def new
      @jobgroup = Jobgroup.new
   end

  # 更新フォーム
   def edit
      @jobgroup = Jobgroup.find(params[:id])
   end

  # 業務区分の新規登録
   def create
      @jobgroup = Jobgroup.new(params[:jobgroup])
      if @jobgroup.save
         redirect_to [:admin, @jobgroup], notice: "業務区分を登録しました。"
      else
         render "new"
      end
   end

  # 業務区分情報の更新
   def update
      @jobgroup = Jobgroup.find(params[:id])
      @jobgroup.assign_attributes(params[:jobgroup])
      if @jobgroup.save
         redirect_to [:admin, @jobgroup], notice: "業務区分情報を更新しました。"
      else
         render "edit"
      end
   end

  # 業務区分の削除
   def destroy
      @jobgroup = Jobgroup.find(params[:id])
      @jobgroup.destroy
      redirect_to :admin_jobgroups, notice: "業務区分を削除しました。"
   end

end
