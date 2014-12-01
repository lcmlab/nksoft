# coding: utf-8

class Admin::SplittimesController < Admin::Base


  layout "nksoft"


  # 勤務時間帯境界モード一覧
   def index
      @splittimes = Splittime.order("id").
        paginate(page: params[:page], per_page: 10)
   end

  # 検索
   def search
      @splittimes = Splittime.search(params[:q]).
        paginate(page: params[:page], per_page: 10)
      render "index"
   end

  # 勤務時間帯境界モード情報の詳細
   def show
#debugger #<< admin splittimes_controller def show(1)  <<<<<<
      @splittime = Splittime.find(params[:id])
   end

  # 新規作成フォーム
   def new
      @splittime = Splittime.new
   end

  # 更新フォーム
   def edit
      @splittime = Splittime.find(params[:id])
   end

  # 勤務時間帯境界モードの新規登録
   def create
      @splittime = Splittime.new(params[:splittime])
      if @splittime.save
         redirect_to [:admin, @splittime], notice: "勤務時間帯境界モードを登録しました。"
      else
         render "new"
      end
   end

  # 勤務時間帯境界モード情報の更新
   def update
      @splittime = Splittime.find(params[:id])
      @splittime.assign_attributes(params[:splittime])
      if @splittime.save
         redirect_to [:admin, @splittime], notice: "勤務時間帯境界モード情報を更新しました。"
      else
         render "edit"
      end
   end

  # 勤務時間帯境界モードの削除
   def destroy
      @splittime = Splittime.find(params[:id])
      @splittime.destroy
      redirect_to :admin_splittimes, notice: "勤務時間帯境界モードを削除しました。"
   end




end
