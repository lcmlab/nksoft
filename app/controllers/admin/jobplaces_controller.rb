# coding: utf-8

class Admin::JobplacesController < Admin::Base

  layout "nksoft"


  # 勤務場所一覧
   def index
      @jobplaces = Jobplace.order("id").
        paginate(page: params[:page], per_page: 10)
   end

  # 検索
   def search
      @jobplaces = Jobplace.search(params[:q]).
        paginate(page: params[:page], per_page: 10)
      render "index"
   end

  # 勤務場所情報の詳細
   def show
#debugger #<< admin jobplaces_controller def show(1)  <<<<<<
      @jobplace = Jobplace.find(params[:id])
   end

  # 新規作成フォーム
   def new
      @jobplace = Jobplace.new
   end

  # 更新フォーム
   def edit
      @jobplace = Jobplace.find(params[:id])
   end

  # 勤務場所の新規登録
   def create
      @jobplace = Jobplace.new(params[:jobplace])
      if @jobplace.save
         redirect_to [:admin, @jobplace], notice: "勤務場所を登録しました。"
      else
         render "new"
      end
   end

  # 勤務場所情報の更新
   def update
      @jobplace = Jobplace.find(params[:id])
      @jobplace.assign_attributes(params[:jobplace])
      if @jobplace.save
         redirect_to [:admin, @jobplace], notice: "勤務場所情報を更新しました。"
      else
         render "edit"
      end
   end

  # 勤務場所の削除
   def destroy
      @jobplace = Jobplace.find(params[:id])
      @jobplace.destroy
      redirect_to :admin_jobplaces, notice: "勤務場所を削除しました。"
   end

end
