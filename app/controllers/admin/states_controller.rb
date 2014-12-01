# coding: utf-8

class Admin::StatesController < Admin::Base

  layout "nksoft"


  # 状況一覧
   def index
      @states = State.
        paginate(page: params[:page], per_page: 15)
   end

  # 検索
   def search
      @states = State.search(params[:q]).
        paginate(page: params[:page], per_page: 15)
      render "index"
   end

  # 状況情報の詳細
   def show
#debugger #<< admin states_controller def show(1)  <<<<<<
      @state = State.find(params[:id])
   end

  # 新規作成フォーム
   def new
      @state = State.new
   end

  # 更新フォーム
   def edit
      @state = State.find(params[:id])
   end

  # 状況の新規登録
   def create
      @state = State.new(params[:state])
      if @state.save
         redirect_to [:admin, @state], notice: "状況を登録しました。"
      else
         render "new"
      end
   end

  # 状況情報の更新
   def update
      @state = State.find(params[:id])
      @state.assign_attributes(params[:state])
      if @state.save
         redirect_to [:admin, @state], notice: "状況情報を更新しました。"
      else
         render "edit"
      end
   end

  # 状況の削除
   def destroy
      @state = State.find(params[:id])
      @state.destroy
      redirect_to :admin_states, notice: "状況を削除しました。"
   end


end
