# coding: utf-8

require ('date')

class Admin::WorkreportsController < Admin::Base

  layout "nksoft"


  # Dynamic Constantの定義
  JAPANESE_WDAY = %w(日 月 火 水 木 金 土)
  #JAPANESE_WDAY = ["sun", "mon", "tue", "wed", "thr", "fri", "sat"]



  # クラス変数への初期値設定
  @@stdate = Date.today.beginning_of_month
  @@enddate = Date.today.end_of_month
  @@fromflg = ""
  @@employee_id

  def index
#debugger # << admin/workreports_controller def index(1)

    @employee = Employee.where(id: session[:user_id]).first

    # ログインユーザが部門長かどうかの判定
    @leader = @employee.leader
    @@leaderflg = @leader # リーダかどうかのフラッグの設定

    @@employee_id = @employee.id # とりあえずログインユーザにしておく

    # 当月の勤務レコードを選択する準備
    stdate = Date.today.beginning_of_month
    enddate = Date.today.end_of_month

#debugger # << admin/workreports_controller def index(2)

    @departments = Department.all
    @clients = Client.all
    @projects = Project.all
    @jobitems = Jobitem.all
    @grades = Grade.all



#debugger # << admin/workreports_controller def index(3)

    @workreports = Workreport.where(employee_id: session[:user_id], workdate: stdate..enddate ).all
    #@workreports = Workreport.where(employee_id: session[:user_id]).order('workdate DESC')
#debugger # << admin/workreports_controller def index(4)
  end


  def show
#debugger # << admin/workreports_controller def show(1)
    @employee = Employee.where(id: session[:user_id]).first

    # ログインユーザが部門長かどうかの判定
    @leader = @employee.leader
    @@leaderflg = @leader # リーダかどうかのフラッグの設定

    @leader = @@leaderflg  # ログインユーザがリーダかどうかのフラッグセット

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
#debugger # << admin/workreports_controller def show(2)
    render "show"
  end


  def edit
#debugger # << admin/workreports_controller def edit(1)
    #@employee = Employee.find(@@employee_id)
    @employee = Employee.where(id: session[:user_id]).first

    # ログインユーザが部門長かどうかの判定
    @leader = @employee.leader
    @@leaderflg = @leader # リーダかどうかのフラッグの設定

    @leader = @@leaderflg  # ログインユーザがリーダかどうかのフラッグセット

    # リーダ氏名をセットする
    if @leader 
       @empleader = Employee.where(id: session[:user_id]).first
    end

    # 対象勤務者氏名のセット
    @employee_name = Employee.find(@@employee_id).name # 勤務者氏名


    @projects = Project.all
    @jobplaces = Jobplace.all
    @jobitems = Jobitem.all
    @addcomments = Addcomment.all
    @grades = Grade.all
    
    @workreport = Workreport.find(params[:id])
  end


  def new
#debugger # << admin/workreports_controller def new(1)
    #@employee = Employee.find(@@employee_id)
    @loginemployee = Employee.where(id: session[:user_id]).first

    # ログインユーザが部門長かどうかの判定
    @leader = @loginemployee.leader
    @@leaderflg = @leader # リーダかどうかのフラッグの設定

    @leader = @@leaderflg  # ログインユーザがリーダかどうかのフラッグセット

    # 新規登録勤務者の情報セット
    @employee = Employee.find(params[:id])
    @employee_id = @employee.id

    @projects = Project.all
    @jobplaces = Jobplace.all
    @jobitems = Jobitem.all
    @addcomments = Addcomment.all
    @grades = Grade.all

    @workreport = Workreport.new(employee_id: @employee.id, timefrom: DateTime.new(2000, 1, 1, 0, 0, 0), timeto: DateTime.new(2000, 1, 1, 1, 0, 0))
    
#debugger # << admin/workreports_controller def new(2)
  end


  def create
#debugger # << admin/workreports_controller def create(1)
    @workreport = Workreport.new(params[:workreport])
    if @workreport.save
         @@fromflg = "new"  # 画面遷移フラグの設定
         redirect_to :controller =>'workreports', :action => 'emp_workreport', notice: "勤務報告情報を登録しました。"

    else
         #@employee = Employee.where(id: @@employee_id).first
         @loginemployee = Employee.where(id: session[:user_id]).first

         # ログインユーザが部門長かどうかの判定
         @leader = @loginemployee.leader
         @@leaderflg = @leader # リーダかどうかのフラッグの設定

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
#debugger # << admin/workreports_controller def update(1)
      @workreport = Workreport.find(params[:id])
      @workreport.assign_attributes(params[:workreport])
      #@@fromflg = params[:workreport][:fromflg]
      if @workreport.save
#debugger # << admin/workreports_controller def update(2)

        @@fromflg = "edit"  # 画面遷移フラグの設定
        redirect_to :controller =>'workreports', :action => 'emp_workreport', notice: "勤務報告情報を更新しました。"
        #redirect_to @workreport, notice: "勤務報告情報を更新しました。"
      else
#debugger # << admin/workreports_controller def update(3)
         render "edit"
      end
  end


  def destroy
#debugger # << admin/workreports_controller def destroy(1)
      @workreport = Workreport.find(params[:id])
      @workreport.destroy
      redirect_to :workreports, :controller =>'workreports', :action => 'emp_workreport', :workreport_id => @workreport, notice: "勤務報告情報を削除しました。"
  end


  # 特定勤務者の勤務報告（時間帯別勤務時間を含む）集計表の作成・表示
  def emplye_wreport
#debugger # << admin/workreports_controller def emplye_wreport(1)
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

#debugger # << admin/workreports_controller def emplye_wreport(1.5)

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

#debugger # << admin/workreports_controller def emplye_wreport(2)
     ewreport = SumWorkReport.new(empid: session[:user_id], stdate: stdate, enddate: enddate, prjid: prjid, jobid: jobid, splittimes: @splittimes)

#debugger # << admin/workreports_controller def emplye_wreport(2.5)

     @emplyewrep = ewreport.employee_wreport # 勤務者の月間勤務報告書データを作成する。
#debugger # << admin/workreports_controller def emplye_wreport(3)

     @workheadcount = ewreport.work_headcount  # 出面集計表を作成する。

debugger # << /admin/workreports_controller def emplye_wreport(4)

     #@emplyewrep = ewreport # 月間勤務報告書データをView用変数に格納する。
     
     render "emplye_wreport"
  end



  # 勤務報告（時間帯別勤務時間を含む）集計表および出面集計表の作成・表示
  def wreport_sammary

#debugger # << /admin/workreports_controller.rb def wreport_sammary (1)

     # 受け渡し用表示範囲設定パラメータの準備
     ewrep_syear = params[:date_S][:year] # 表示開始日
     ewrep_smonth = params[:date_S][:month]
     ewrep_sday = params[:date_S][:day]
     stdate = Date::new(ewrep_syear.to_i, ewrep_smonth.to_i, ewrep_sday.to_i)

     ewrep_eyear = params[:date_E][:year]   # 表示終了日
     ewrep_emonth = params[:date_E][:month]
     ewrep_eday = params[:date_E][:day]
     enddate = Date::new(ewrep_eyear.to_i, ewrep_emonth.to_i, ewrep_eday.to_i)

     @sammarycode = params[:sammarytarget] # 集計対象区分コード 
     # 　                （ "1"：部門別集計, "2"：客先別集計, "3"：個人別集計）
     @departmentcode = params[:department] # 所属部門IDコード
     @clientcode = params[:client]     # 顧客IDコード

     #@ewrep_prj = params[:project]       # 勤務先コード　"":全て
     #@ewrep_jobitem = params[:jobitem]   # 勤務内容コード　"":全て



     #@employee = Employee.where(id: session[:user_id]).first

     load 'Summary_Workreports_Load.rb' # レポート作成モジュールのロード

     prjid = @ewrep_prj
     jobid = @ewrep_jobitem

     sammarycd = @sammarycode
     departmentcd = @departmentcode
     clientcd = @clientcode

     # 勤務時間帯モード情報をセットする
     @splittimes = Splittime.all

#debugger # << /admin/workreports_controller def wreport_sammary(2)

     ewreport = SumWorkReport.new(session[:user_id], stdate, enddate, prjid, jobid, sammarycd, departmentcd, clientcd, @splittimes)

#debugger # << /admin/workreports_controller def wreport_sammary(2.5)

     @emplyewrep = ewreport.employee_wreport # 勤務者の月間勤務報告書データを作成する。

#debugger # << /admin/workreports_controller def wreport_sammary(3)

     
     @workheadcount = ewreport.work_headcount  # 出面集計表を作成する。
     @hcstdate = stdate
     @hcenddate = enddate
     # 年月日
     @hcstdatengp = nengappi(@hcstdate)
     @hcenddatengp = nengappi(@hcenddate)

#debugger # << /admin/workreports_controller def wreport_sammary(4)

     #@emplyewrep = ewreport # 月間勤務報告書データをView用変数に格納する。
     
     render "wreport_sammary"

  end



#-----------------------------------------------------------------------------
  # 勤務者データ表示範囲設定パラメータのセット
   def set_empdsprange
#debugger # << admin/workreports_controller def set_empdsprange(1)

    # 
    @employees = Workreport.joins(:employee).uniq.select("employees.id, employees.name")

#debugger # << admin/workreports_controller def set_empdsprange(2)

    #@clients = Client.all
    #@projects = Project.all
    #@jobitems = Jobitem.all

    # 当月の勤務レコードを選択する準備
    stdate = Date.today.beginning_of_month
    enddate = Date.today.end_of_month

    #@departments = Employee.department.all

#debugger # << admin/workreports_controller def set_empdsprange(3)

      render "set_empdsprange"
   end



   # 特定勤務者の勤務情報管理処理
   def emp_workreport
#debugger # << admin/workreports_controller def emp_workreport(1)

     # 受け渡し用表示範囲設定パラメータの準備
    if params[:fromflg] == "show" || params[:fromflg] == "edit" || @@fromflg == "edit" || @@fromflg == "new"   # 直前のShowまたはEdit画面からの戻りの場合
       stdate = @@stdate
       enddate = @@enddate
       #@employee = params[:employee]
       @employee_id = @@employee_id       # 表示する特定勤務者ID
       @employee_name = Employee.find(@employee_id).name # 勤務者氏名
       @@fromflg = ""  # 遷移画面間フラグをリセットする。

#debugger # << admin/workreports_controller def emp_workreport(1.5)

    else             # set_empdsprange画面からの遷移（正規の遷移順）
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

       @employee_id = params[:employee]       # 表示する特定勤務者ID
       @employee_name = Employee.find(@employee_id).name # 勤務者氏名
       @@employee_id = params[:employee]
    end


#debugger # << admin/workreports_controller def emp_workreport(2)

     @workreports = Workreport.where(employee_id: @employee_id, workdate: stdate..enddate ).all

#debugger # << admin/workreports_controller def emp_workreport(3)

      render "emp_workreport"

   end



  def nengappi (dateinf) # 標準日付の年月日曜日表現を作成する
#debugger # << SumWorkReportクラス def nengappi (1)

     nengappiinf = dateinf.year.to_s << "年" << dateinf.month.to_s << "月"
     nengappiinf = nengappiinf << dateinf.day.to_s << "日 " 
     nengappiinf = nengappiinf << JAPANESE_WDAY[dateinf.wday]

#debugger # << SumWorkReportクラス def nengappi (2)


     nengappiinf
  end


end
