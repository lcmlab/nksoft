# coding: utf-8

class WorkreportsController < ApplicationController

  layout "nksoft"


  # クラス変数への初期値設定
  @@stdate = Date.today.beginning_of_month
  @@enddate = Date.today.end_of_month
  @@fromflg = ""
  @@leaderflg = false
  @@employee_id


  def index
#debugger # << workreports_controller def index(1)

    @employee = Employee.where(id: session[:user_id]).first

    # ログインユーザが部門長かどうかの判定
    @leader = @employee.leader
    @@leaderflg = @leader # リーダかどうかのフラッグの設定

    @@employee_id = @employee.id
    

#debugger # << workreports_controller def index(2)

    @projects = Workreport.joins(:project).uniq.where(employee_id: session[:user_id]).select("projects.id, projects.prjname").all
    #@projects = Project.all
    @jobitems = Jobitem.all
    @grades = Grade.all

    # 当月の勤務レコードを選択する準備
    stdate = Date.today.beginning_of_month
    enddate = Date.today.end_of_month

#debugger # << workreports_controller def index(3)

    # ここでセットするのはログインユーザ個人の今月分勤務情報レコードのみとする。
    @workreports = Workreport.where(employee_id: session[:user_id], workdate: stdate..enddate ).all

#debugger # << workreports_controller def index(4)
  end


  def show
#debugger # << workreports_controller def show(1)
    @employee = Employee.where(id: session[:user_id]).first

    # ログインユーザが部門長かどうかの判定
    @leader = @employee.leader
    @@leaderflg = @leader # リーダかどうかのフラッグの設定

    @leader = @@leaderflg  # ログインユーザがリーダかどうかのフラッグセット


    #@leader = @@leaderflg

    #@employee = Employee.where(id: session[:user_id]).first

    # リーダ氏名をセットする
    if @leader 
       @empleader = Employee.where(id: session[:user_id]).first
    end

    # 対象勤務者氏名のセット
    #@@employee_id = params[:employee]
    @employee_name = Employee.find(@@employee_id).name # 勤務者氏名

    #@projects = Project.all
    #@jobplaces = Jobplace.all
    #@jobitems = Jobitem.all
    #@addcomments = Addcomment.all
    #@grades = Grade.all

    @workreport = Workreport.find(params[:id])
#debugger # << workreports_controller def show(2)
    render "show"
  end


  def edit
#debugger # << workreports_controller def edit(1)
    @employee = Employee.where(id: session[:user_id]).first

    # ログインユーザが部門長かどうかの判定
    @leader = @employee.leader
    @@leaderflg = @leader # リーダかどうかのフラッグの設定

    @leader = @@leaderflg  # ログインユーザがリーダかどうかのフラッグセット


    #@employee = Employee.find(session[:user_id])
    #@employee = Employee.find(:id])

    # リーダ氏名をセットする
    if @leader 
       @empleader = Employee.where(id: session[:user_id]).first
    end


    # 対象勤務者氏名のセット
    #@@employee_id = params[:employee]
    @employee_name = Employee.find(@@employee_id).name # 勤務者氏名


    @projects = Project.all
    @jobplaces = Jobplace.all
    @jobitems = Jobitem.all
    @addcomments = Addcomment.all
    @grades = Grade.all
    
    @workreport = Workreport.find(params[:id])

#debugger # << workreports_controller def edit(2)

  end


  def new
#debugger # << workreports_controller def new(1)
    @loginemployee = Employee.where(id: session[:user_id]).first

    # ログインユーザが部門長かどうかの判定
    @leader = @loginemployee.leader
    @@leaderflg = @leader # リーダかどうかのフラッグの設定

    @leader = @@leaderflg  # ログインユーザがリーダかどうかのフラッグセット

#debugger # << workreports_controller def new(2)

    # 新規登録勤務者の情報セット
    @employee = Employee.find(params[:id])
    @employee_id = @employee.id

#debugger # << workreports_controller def new(3)

    @projects = Project.all
    @jobplaces = Jobplace.all
    @jobitems = Jobitem.all
    @addcomments = Addcomment.all
    @grades = Grade.all

    @workreport = Workreport.new(employee_id: @employee.id, timefrom: DateTime.new(2000, 1, 1, 0, 0, 0), timeto: DateTime.new(2000, 1, 1, 1, 0, 0))
    #@workreport = Workreport.new(employee_id: @employee.id, timefrom: Time.now, timeto: Time.now)

#debugger # << workreports_controller def new(2)
  end


  def create
#debugger # << workreports_controller def create(1)
    @workreport = Workreport.new(params[:workreport])
    if @workreport.save
         @@fromflg = "new"  # 画面遷移フラグの設定
         #redirect_to @workreport, notice: "勤務報告情報を登録しました。"
         redirect_to :controller =>'workreports', :action => 'subord_workreport', notice: "勤務報告情報を登録しました。"

      else
         @loginemployee = Employee.where(id: session[:user_id]).first

         # ログインユーザが部門長かどうかの判定
         @leader = @loginemployee.leader
         @@leaderflg = @leader # リーダかどうかのフラッグの設定

         #@leader = @@leaderflg  # ログインユーザがリーダフラッグセット

         @employee = Employee.where(id: @@employee_id).first
         #@employee = Employee.where(id: session[:user_id]).first

         # リーダ氏名をセットする
         if @leader 
            @empleader = Employee.where(id: session[:user_id]).first
         end

         # 対象勤務者氏名のセット
         #@@employee_id = params[:employee] #### 
         @employee_name = Employee.find(@@employee_id).name # 勤務者氏名

         @projects = Project.all
         @jobplaces = Jobplace.all
         @jobitems = Jobitem.all
         @addcomments = Addcomment.all
         @grades = Grade.all

         render "new"
      end
  end


  def update
#debugger # << workreports_controller def update(1)
      @workreport = Workreport.find(params[:id])
      @workreport.assign_attributes(params[:workreport])
      if @workreport.save
#debugger # << workreports_controller def update(2)

        @@fromflg = "edit"  # 画面遷移フラグの設定
        #redirect_to @workreport, notice: "勤務報告情報を更新しました。"
        redirect_to :controller =>'workreports', :action => 'subord_workreport', notice: "勤務報告情報を更新しました。"

      else
#debugger # << workreports_controller def update(3)
         render "edit"
      end
  end


  def destroy
#debugger # << workreports_controller def destroy(1)
      @workreport = Workreport.find(params[:id])
      @workreport.destroy
      #redirect_to :workreports, :controller =>'workreports', :action => 'index',:workreport_id => @workreport, notice: "勤務報告情報を削除しました。"
      redirect_to :workreports, :controller =>'workreports', :action => 'subord_workreport', :workreport_id => @workreport, notice: "勤務報告情報を削除しました。"
  end


  def emplye_wreport
#debugger # << workreports_controller def emplye_wreport(1)
     # 受け渡し用表示範囲設定パラメータの準備
     ewrep_syear = params[:date_S][:year] # 表示開始日
     ewrep_smonth = params[:date_S][:month]
     ewrep_sday = params[:date_S][:day]
     stdate = Date::new(ewrep_syear.to_i, ewrep_smonth.to_i, ewrep_sday.to_i)

     ewrep_eyear = params[:date_E][:year]   # 表示終了日
     ewrep_emonth = params[:date_E][:month]
     ewrep_eday = params[:date_E][:day]
     enddate = Date::new(ewrep_eyear.to_i, ewrep_emonth.to_i, ewrep_eday.to_i)

     @ewrep_prj = params[:project]       # 勤務先コード　"":全て
     @ewrep_jobitem = params[:jobitem]   # 勤務内容コード　"":全て

     @employee = Employee.where(id: session[:user_id]).first

#debugger # << workreports_controller def emplye_wreport(1.5)

     load 'Summary_Workreports_Load.rb' # レポート作成モジュールのロード
     # 勤務報告書データ作成用パラメータのセット
     #stdate = Date.new(2014, 5, 1)
     #stdate = @ewrep_sdate
     #enddate = Date.new(2014, 5, 31)
     #enddate = @ewrep_edate

     prjid = @ewrep_prj
     jobid = @ewrep_jobitem

     # 勤務時間帯モード情報をセットする
     @splittimes = Splittime.all

#debugger # << workreports_controller def emplye_wreport(2)
     ewreport = SumWorkReport.new(session[:user_id], stdate, enddate, prjid, jobid, @splittimes)

#debugger # << workreports_controller def emplye_wreport(2.5)

     @emplyewrep = ewreport.employee_wreport # 勤務者の月間勤務報告書データを作成する。

#debugger # << workreports_controller def emplye_wreport(3)
     
     render "emplye_wreport"
  end




#-----------------------------------------------------------------------------
  # 部下の勤務者データ編集範囲設定パラメータのセット
   def set_subordsprange
debugger # << workreports_controller def set_subordsprange(1)


    # ログインユーザが部門長かどうかの判定
    @leaderattrs = Employee.where(id: session[:user_id]).first

#debugger # << workreports_controller def index(3.5)

    @leader = @leaderattrs.leader
    deptid = @leaderattrs.department_id
    if @leader then  # ログインユーザが部門長の場合
       @employees = Employee.where(department_id: deptid).select('id, name').all
       @empleader = Employee.where(id: session[:user_id]).first 
    else # 部門長以外のユーザの場合
       @employees = Employee.where(id: session[:user_id]).select('id, name').all
    end



    #@employees = Workreport.joins(:employee).uniq.select("employees.id, employees.name")

#debugger # << workreports_controller def set_subordsprange(2)

    #@clients = Client.all
    #@projects = Project.all
    #@jobitems = Jobitem.all

    # 当月の勤務レコードを選択する準備
    stdate = Date.today.beginning_of_month
    enddate = Date.today.end_of_month

    #@departments = Employee.department.all

#debugger # << workreports_controller def set_subordsprange(3)

      render "set_subordsprange"
   end



   # 部下の特定勤務者の勤務情報管理処理
   def subord_workreport
#debugger # << workreports_controller def subord_workreport(1)

    @leader = @@leaderflg

     # 受け渡し用表示範囲設定パラメータの準備
    if params[:fromflg] == "show" || params[:fromflg] == "edit" || @@fromflg == "edit" || @@fromflg == "new"   # 直前のShowまたはEdit画面からの戻りの場合
       stdate = @@stdate
       enddate = @@enddate
       #@employee = params[:employee]
       @employee_id = @@employee_id    ###   # 表示する特定勤務者ID
       @employee_name = Employee.find(@employee_id).name # 勤務者氏名
       @@fromflg = ""  # 遷移画面間フラグをリセットする。

#debugger # << workreports_controller def subord_workreport(1.5)

    else             # set_subordsprange画面からの遷移（正規の遷移順）
       ewrep_syear = params[:date_S][:year] # 表示開始日
       ewrep_smonth = params[:date_S][:month]
       ewrep_sday = params[:date_S][:day]
       stdate = Date::new(ewrep_syear.to_i, ewrep_smonth.to_i, ewrep_sday.to_i)
       @@stdate = stdate

       ewrep_eyear = params[:date_E][:year]   # 表示終了日
       ewrep_emonth = params[:date_E][:month]
       ewrep_eday = params[:date_E][:day]
       enddate = Date::new(ewrep_eyear.to_i, ewrep_emonth.to_i, ewrep_eday.to_i)
       @@enddate = enddate

       # 対象勤務者氏名のセット
       @employee_id = params[:employee]       # 表示する特定勤務者ID
       @employee_name = Employee.find(@employee_id).name # 勤務者氏名
       @@employee_id = params[:employee]
    end


#debugger # << workreports_controller def subord_workreport(2)
    # リーダ氏名をセットする
    if @leader
       @empleader = Employee.where(id: session[:user_id]).first
    end


    @workreports = Workreport.where(employee_id: @employee_id, workdate: stdate..enddate ).all

#debugger # << workreports_controller def emp_workreport(3)

      render "subord_workreport"

   end



# ===================================================================
   # 部下の勤務者の勤務情報一括登録データ入力
   def subord_bulkworkreport
debugger # << workreports_controller def subord_bulkworkreport(1)

    @leader = @@leaderflg

     # 受け渡し用表示範囲設定パラメータの準備
    if params[:fromflg] == "show" || params[:fromflg] == "edit" || @@fromflg == "edit" || @@fromflg == "new"   # 直前のShowまたはEdit画面からの戻りの場合
       stdate = @@stdate
       enddate = @@enddate
       #@employee = params[:employee]
       @employee_id = @@employee_id    ###   # 表示する特定勤務者ID
       @employee_name = Employee.find(@employee_id).name # 勤務者氏名
       @@fromflg = ""  # 遷移画面間フラグをリセットする。

#debugger # << workreports_controller def subord_bulkworkreport(1.5)

    else             # set_subordsprange画面からの遷移（正規の遷移順）
       ewrep_syear = params[:date_S][:year] # 表示開始日
       ewrep_smonth = params[:date_S][:month]
       ewrep_sday = params[:date_S][:day]
       stdate = Date::new(ewrep_syear.to_i, ewrep_smonth.to_i, ewrep_sday.to_i)
       @@stdate = stdate

       ewrep_eyear = params[:date_E][:year]   # 表示終了日
       ewrep_emonth = params[:date_E][:month]
       ewrep_eday = params[:date_E][:day]
       enddate = Date::new(ewrep_eyear.to_i, ewrep_emonth.to_i, ewrep_eday.to_i)
       @@enddate = enddate

       # 対象勤務者氏名のセット
       @employee_id = params[:employee]       # 表示する特定勤務者ID
       @employee_name = Employee.find(@employee_id).name # 勤務者氏名
       @@employee_id = params[:employee]
    end


#debugger # << workreports_controller def subord_bulkworkreport(2)
    # リーダ氏名をセットする
    if @leader
       @empleader = Employee.where(id: session[:user_id]).first
    end


    @workreports = Workreport.where(employee_id: @employee_id, workdate: stdate..enddate ).all

#debugger # << workreports_controller def subord_bulkworkreport(3)

      render "subord_bulkworkreport"

   end



  # 部下の勤務者データ一括編集範囲設定パラメータのセット
   def set_bulksubordinp1
debugger # << workreports_controller def set_bulksubordinp1(1)


    # ログインユーザが部門長かどうかの判定
    @leaderattrs = Employee.where(id: session[:user_id]).first

#debugger # << workreports_controller def set_bulksubordinp1(3.5)

    @leader = @leaderattrs.leader
    deptid = @leaderattrs.department_id
    if @leader then  # ログインユーザが部門長の場合
       @employees = Employee.where(department_id: deptid).select('id, name').all
       @empleader = Employee.where(id: session[:user_id]).first 
    else # 部門長以外のユーザの場合
       @employees = Employee.where(id: session[:user_id]).select('id, name').all
    end

#debugger # << workreports_controller def set_bulksubordinp1(2)

    # 当月の勤務レコードを選択する準備
    stdate = Date.today.beginning_of_month
    enddate = Date.today.end_of_month


    # 選択ボックス表示用データ準備
    @projects = Project.all
    @jobplaces = Jobplace.all
    @jobitems = Jobitem.all
    @addcomments = Addcomment.all
    @grades = Grade.all

debugger # << workreports_controller def set_bulksubordinp1(3)

      render "set_bulksubordinp1"
   end




   def set_bulksubordinpconfirm
debugger # << workreports_controller def set_bulksubordinpconfirm(1)

    # ログインユーザが部門長かどうかの判定
    @leaderattrs = Employee.where(id: session[:user_id]).first
    @leader = @leaderattrs.leader
    deptid = @leaderattrs.department_id
    if @leader then  # ログインユーザが部門長の場合（全部下勤務者レコード準備）
       @employees = Employee.where(department_id: deptid).select('id, name').all
       @empleader = Employee.where(id: session[:user_id]).first 
    else # 部門長以外のユーザの場合（ログイン勤務者レコードのみを準備）
       @employees = Employee.where(id: session[:user_id]).select('id, name').all
    end


    # 選択された新規情報登録候補勤務者配列を作成する
    empnum = params[:employee].length
    @emplist = make_nm_array(empnum,2)
    empsum = 0
    for @employee in @employees do
       eid = @employee.id.to_s
       if params[:employee][eid][:regist_check] == "1" then
          # 配列には選択された候補勤務者のみのidと氏名を格納する
          @emplist[empsum][0] = params[:employee][eid][:id]
          @emplist[empsum][1] = @employee.name
          empsum = empsum + 1
       end
    end


    # 登録日付範囲パラメータの引き受け
       ewrep_syear = params[:date_S][:year] # 表示開始日
       ewrep_smonth = params[:date_S][:month]
       ewrep_sday = params[:date_S][:day]
       stdate = Date::new(ewrep_syear.to_i, ewrep_smonth.to_i, ewrep_sday.to_i)

       @@stdate = stdate
       @regist_stdate = stdate

       ewrep_eyear = params[:date_E][:year]   # 表示終了日
       ewrep_emonth = params[:date_E][:month]
       ewrep_eday = params[:date_E][:day]
       enddate = Date::new(ewrep_eyear.to_i, ewrep_emonth.to_i, ewrep_eday.to_i)
       @@enddate = enddate
       @regist_enddate = enddate

       @regist_project = Project.find(params[:project]["project_id"])
       @regist_grade = Grade.find(params[:grade]["grade_id"])
       @regist_jobplace =Jobplace.find(params[:jobplace]["jobplace_id"])
       @regist_jobitem = Jobitem.find(params[:jobitem]["jobitem_id"])
       #@regist_timefromH = params[:timefrom]["hour"]
       #@regist_timefromM = params[:timefrom]["minute"]
       @regist_timefrom = Time.new(2000, 1, 1, params[:timefrom]["hour"], params[:timefrom]["minute"], 0)

       #@regist_timetoH = params[:timeto]["hour"]
       #@regist_timetoM = params[:timeto]["minute"]
       @regist_timeto = Time.new(2000, 1, 1, params[:timeto]["hour"], params[:timeto]["minute"], 0)

       @regist_addcomment = Addcomment.find(params[:addcomment]["addcomment_id"])
       
debugger # << workreports_controller def set_bulksubordinpconfirm(2)

    # 一括登録勤務情報パラメータの読込み

    render "set_bulksubordinpconfirm"

   end



  def subord_bulkcreate
debugger # << workreports_controller def subord_bulkcreate(1)


    # 一括登録日数を確認
    edate = Date.parse(params[:enddate])
    sdate = Date.parse(params[:stdate])
    registdays = (edate - sdate).to_i + 1

    # 一括登録部下勤務者数を確認
    registemps = params[:employee].length
debugger # << workreports_controller def subord_bulkcreate(1.5)
    # 部下の一括勤務情報の登録処理
     # 各一括登録日付について
    for nday in 1..registdays do
       ragist_date = sdate + (nday - 1)

       # 各一括登録部下勤務者について
       for iemp in 1..registemps do
          ragist_empid = params[:employee][iemp - 1].to_i

          @workreport = Workreport.new(employee_id: ragist_empid, 
               project_id: params[:project_id], 
               jobplace_id: params[:jobplace_id], 
               jobitem_id: params[:jobitem_id], 
               workdate: ragist_date, 
               timefrom: params[:timefrom], 
               timeto: params[:timeto], 
               addcomment_id: params[:addcomment_id], 
               grade_id: params[:grade_id])

debugger # << workreports_controller def subord_bulkcreate(2)

          # レコードのDB登録
          @workreport.save

       end # 一括登録勤務者のループend

    end # 一括登録日のループend


    #
    if @workreport.save
         @@fromflg = "subord_bulkcreate"  # 画面遷移フラグの設定
         redirect_to :controller =>'workreports', :action => 'set_bulksubordinp1', notice: "勤務報告情報を一括登録しました。"

      else
         @loginemployee = Employee.where(id: session[:user_id]).first

         # ログインユーザが部門長かどうかの判定
         @leader = @loginemployee.leader
         @@leaderflg = @leader # リーダかどうかのフラッグの設定

         #@leader = @@leaderflg  # ログインユーザがリーダフラッグセット

         @employee = Employee.where(id: @@employee_id).first
         #@employee = Employee.where(id: session[:user_id]).first

         # リーダ氏名をセットする
         if @leader 
            @empleader = Employee.where(id: session[:user_id]).first
         end

         # 対象勤務者氏名のセット
         #@@employee_id = params[:employee] #### 
         @employee_name = Employee.find(@@employee_id).name # 勤務者氏名

         @projects = Project.all
         @jobplaces = Jobplace.all
         @jobitems = Jobitem.all
         @addcomments = Addcomment.all
         @grades = Grade.all

         render "set_bulksubordinp1"
      end
  end



#=============================================================================
   private
   def make_nm_array(n,m)
      (0..n).map{ Array.new(m) }
   end

end
