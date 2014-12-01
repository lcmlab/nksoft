# coding: utf-8

class Admin::AddcommentsController < Admin::Base

  layout "nksoft"


  # 備考一覧
   def index
      @addcomments = Addcomment.order("id").
        paginate(page: params[:page], per_page: 15)
   end

  # 検索
   def search
      @addcomments = Addcomment.search(params[:q]).
        paginate(page: params[:page], per_page: 15)
      render "index"
   end

  # 備考情報の詳細
   def show
#debugger #<< admin addcomments_controller def show(1)  <<<<<<
      @addcomment = Addcomment.find(params[:id])
   end

  # 新規作成フォーム
   def new
      @addcomment = Addcomment.new
   end

  # 更新フォーム
   def edit
      @addcomment = Addcomment.find(params[:id])
   end

  # 備考の新規登録
   def create
      @addcomment = Addcomment.new(params[:addcomment])
      if @addcomment.save
         redirect_to [:admin, @addcomment], notice: "備考を登録しました。"
      else
         render "new"
      end
   end

  # 備考情報の更新
   def update
      @addcomment = Addcomment.find(params[:id])
      @addcomment.assign_attributes(params[:addcomment])
      if @addcomment.save
         redirect_to [:admin, @addcomment], notice: "備考情報を更新しました。"
      else
         render "edit"
      end
   end

  # 備考の削除
   def destroy
      @addcomment = Addcomment.find(params[:id])
      @addcomment.destroy
      redirect_to :admin_addcomments, notice: "備考を削除しました。"
   end

end
