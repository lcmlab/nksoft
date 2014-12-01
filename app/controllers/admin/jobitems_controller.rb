# coding: utf-8

class Admin::JobitemsController < Admin::Base

  layout "nksoft"


  # 業務項目一覧
   def index
      @jobitems = Jobitem.order("id").
        paginate(page: params[:page], per_page: 10)
   end

  # 検索
   def search
      @jobitems = Jobitem.search(params[:q]).
        paginate(page: params[:page], per_page: 10)
      render "index"
   end

  # 業務項目情報の詳細
   def show
#debugger #<< admin jobitems_controller def show(1)  <<<<<<
      @jobitem = Jobitem.find(params[:id])
   end

  # 新規作成フォーム
   def new
      @jobgroups = Jobgroup.all
      @jobitem = Jobitem.new
   end

  # 更新フォーム
   def edit
      @jobgroups = Jobgroup.all
      @jobitem = Jobitem.find(params[:id])
   end

  # 業務項目の新規登録
   def create
      @jobitem = Jobitem.new(params[:jobitem])
      if @jobitem.save
         redirect_to [:admin, @jobitem], notice: "業務項目を登録しました。"
      else
         render "new"
      end
   end

  # 業務項目情報の更新
   def update
      @jobitem = Jobitem.find(params[:id])
      @jobitem.assign_attributes(params[:jobitem])
      if @jobitem.save
         redirect_to [:admin, @jobitem], notice: "業務項目情報を更新しました。"
      else
         render "edit"
      end
   end

  # 業務項目の削除
   def destroy
      @jobitem = Jobitem.find(params[:id])
      @jobitem.destroy
      redirect_to :admin_jobitems, notice: "業務項目を削除しました。"
   end

end
