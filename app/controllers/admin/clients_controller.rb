# coding: utf-8

class Admin::ClientsController < Admin::Base
  #before_filter :login_required

  layout "nksoft"


  # 顧客一覧
   def index
      @clients = Client.order("id").
        paginate(page: params[:page], per_page: 10)
   end

  # 検索
   def search
      @clients = Client.search(params[:q]).
        paginate(page: params[:page], per_page: 10)
      render "index"
   end

  # 顧客情報の詳細
   def show
#debugger #<< admin clients_controller def show(1)  <<<<<<
      @client = Client.find(params[:id])
   end

  # 新規作成フォーム
   def new
      @client = Client.new
   end

  # 更新フォーム
   def edit
      @client = Client.find(params[:id])
   end

  # 顧客の新規登録
   def create
      @client = Client.new(params[:client])
      if @client.save
         redirect_to [:admin, @client], notice: "顧客を登録しました。"
      else
         render "new"
      end
   end

  # 顧客情報の更新
   def update
      @client = Client.find(params[:id])
      @client.assign_attributes(params[:client])
      if @client.save
         redirect_to [:admin, @client], notice: "顧客情報を更新しました。"
      else
         render "edit"
      end
   end

  # 顧客の削除
   def destroy
      @client = Client.find(params[:id])
      @client.destroy
      redirect_to :admin_clients, notice: "顧客を削除しました。"
   end

end
