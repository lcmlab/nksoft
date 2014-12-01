# encoding: utf-8


require ('date')


class SumWorkReport
#
# Workreport
#

   # Dynamic Constantの定義
   JAPANESE_WDAY = %w(日 月 火 水 木 金 土)
   #JAPANESE_WDAY = ["sun", "mon", "tue", "wed", "thr", "fri", "sat"]

   # インスタンス変数読み出し専用アクセサ定義
   attr_reader :employee_id, :fromdate, :todate
   attr_reader :projectcd, :jobitemcd
   attr_reader :workreports
   attr_reader :sammarycd, :departmentcd, :clientcd
   attr_reader :splittimes


   def initialize(empid="0", stdate="0", enddate="0", prjid="0", jobid="0", sammarycd="0", departmentcd="0", clientcd="0", splittimes)

#debugger #<<< SumWorkReportクラス def initialize（1） <<<<<<<<<<<

      @employee_id = empid
      @fromdate = stdate
      @todate = enddate
      @projectcd = prjid
      @jobitemcd = jobid

      @sammarycd = sammarycd
      @departmentcd = departmentcd
      @clientcd = clientcd

      @splittimes = splittimes


      # 集計方法毎の勤務データをセットする

      case sammarycd   
      when "0"    # 通常ユーザの個人勤務集計用データ
         
         private_wrep

      when "1"  # 部門別集計用データ
         
         departments_wrep

      when "2"  # 客先別集計用データ
         
         clients_wrep

      when "3"  # 個人別集計用データ（？実装するの？？）
         
         employees_wrep

      end

#debugger #<<< SumWorkReportクラス def initialize（2） <<<<<<<<<<<

   end



   def clients_wrep # 顧客別集計用データ
      
#debugger #  << SumWorkReportクラス def clients_wrep（1） <<<<<<<<<<<

      case self.clientcd
      when ""  # 全顧客
         @workreports = Workreport.joins(:project => :client).where(workdate: self.fromdate..self.todate).order('client_id, employee_id').select('workreports.*, clients.clientname').all

      else  # 特定顧客（一度では特定顧客のみの取出しが難しいため一旦すべてをＧＥＴする。
         @workrepts = Workreport.joins(:project => :client).where(workdate: self.fromdate..self.todate).order('employee_id').select('workreports.*, clients.clientname').all

         # 次に、インスタンス変数から特定顧客名のレコードのみをインスタンス変数に取り出す。
         clientname = Client.where(id: clientcd).select('clientname').first
         clitname = clientname.clientname
         @workreports = @workrepts.find_all{|elem| elem.clientname == clitname}
      end

#debugger #  << SumWorkReportクラス def clients_wrep（2） <<<<<<<<<<<

      @workreports
   end





   def departments_wrep # 部門別集計用データ
      
#debugger #  << SumWorkReportクラス def departments_wrep（1） <<<<<<<<<<<

      case self.departmentcd
      when ""  # 全部門
         @workreports = Workreport.joins(:employee => :department).where(workdate: self.fromdate..self.todate).order('department_id, employee_id').select('workreports.*, departments.dpname')

      else  # 特定部門（一度では特定部門のみの取出しが難しいため一旦すべてをＧＥＴする。
         @workrepts = Workreport.joins(:employee => :department).where(workdate: self.fromdate..self.todate).order('employee_id').select('workreports.*, departments.dpname')

         # 次に、インスタンス変数から特定部門名のレコードのみをインスタンス変数に取り出す。
         departmentname = Department.where(id: departmentcd).select('dpname').first
         deptname = departmentname.dpname
         @workreports = @workrepts.find_all{|elem| elem.dpname == deptname}
      end

#debugger #  << SumWorkReportクラス def departments_wrep（2） <<<<<<<<<<<

      @workreports
   end








   def private_wrep
      #
      # 報告データ作成用の各指定パラメータに対応する勤務情報の絞り込み
      #
#debugger #<<< SumWorkReportクラス def private_wrep（1） <<<<<<<<<<<      
      case self.projectcd
      when ""
         case self.jobitemcd
         when ""  # 全プロジェクト、全勤務内容
            @workreports = Workreport.where(employee_id: self.employee_id, workdate: self.fromdate..self.todate).all

         else    # 全プロジェクト、特定勤務内容
            @workreports = Workreport.where(employee_id: self.employee_id, workdate: self.fromdate..self.todate, jobitem_id: self.jobitemcd).all
            
         end
      else
         case self.jobitemcd
         when ""  # 特定プロジェクト、全勤務内容
            @workreports = Workreport.where(employee_id: self.employee_id, workdate: self.fromdate..self.todate, project_id: self.projectcd).all
             
         else    # 特定プロジェクト、特定勤務内容
            @workreports = Workreport.where(employee_id: self.employee_id, workdate: self.fromdate..self.todate, jobitem_id: self.jobitemcd, project_id: self.projectcd).all
            
         end
      end

#debugger #<<< SumWorkReportクラス def private_wrep（2） <<<<<<<<<<<

      @workreports

   end





   def employee_wreport  # 勤務者の月間勤務報告書データを作成する。

#debugger # << SumWorkReportクラス def employee_wreport (1)

begin
      height = self.workreports.size + 1
      width = 9 + 9
      ewrepm = Array.new(height).map!{ Array.new(width,0)}

      zonetimes = []

#debugger # << SumWorkReportクラス def employee_wreport (1.5)

      # 時間帯別作業時間集計値のリセット
      totaltimes = 0.0
      zone6timesum = 0.0
      zone5timesum = 0.0
      zone4timesum = 0.0
      zone3timesum = 0.0
      zone2timesum = 0.0
      zone1timesum = 0.0

      rth = 0
      self.workreports.each do |row|
print rth
            ewrepm[rth][0]  = row.employee_id
            ewrepm[rth][1]  = row.workdate
            ewrepm[rth][2]  = row.project.prjname
            ewrepm[rth][3]  = row.jobplace.jobplacename
            ewrepm[rth][4]  = row.grade.gradename
            ewrepm[rth][5]  = row.jobitem.jobname
            ewrepm[rth][6]  = row.timefrom
            ewrepm[rth][7]  = row.timeto

#debugger # << SumWorkReportクラス def employee_wreport (1.54)


            ewrepm[rth][8]  = (row.timeto - row.timefrom)/3600.0
               totaltimes = totaltimes + ewrepm[rth][8]
            ewrepm[rth][9]  = row.addcomment.comment
            
            # この勤務作業プロジェクトの対象勤務時間帯を設定する。
            splittime_id = row.project.splittime_id
            @splittime = self.splittimes.find{|elem| elem.id == splittime_id}
            
            bt1 = @splittime.splittime1
            bt2 = @splittime.splittime2
            bt3 = @splittime.splittime3
            bt4 = @splittime.splittime4
            bt5 = @splittime.splittime5
            bt6 = @splittime.splittime6

#debugger # << SumWorkReportクラス def employee_wreport (1.55)

            # 作業開始終了時刻から各時間帯別作業時間を算出する。
            zonetimes = analizewt(row.timefrom, row.timeto, bt1, bt2, bt3, bt4, bt5, bt6)
            
            ewrepm[rth][10]  = zonetimes[0]
              zone1timesum = zone1timesum + zonetimes[0]
            ewrepm[rth][11]  = zonetimes[1]
              zone2timesum = zone2timesum + zonetimes[1]
            ewrepm[rth][12]  = zonetimes[2]
              zone3timesum = zone3timesum + zonetimes[2]
            ewrepm[rth][13]  = zonetimes[3]
              zone4timesum = zone4timesum + zonetimes[3]
            ewrepm[rth][14]  = zonetimes[4]
              zone5timesum = zone5timesum + zonetimes[4]
            ewrepm[rth][15]  = zonetimes[5]
              zone6timesum = zone6timesum + zonetimes[5]

            # 勤務者と所属部門／顧客名称を格納する

#debugger # << SumWorkReportクラス def employee_wreport (1.6)


               ewrepm[rth][16]  = row.employee.name
               #ewrepm[rth][15]  = "名無しさん"
            

            case self.sammarycd
            when "1" then
               ewrepm[rth][17]  = row.dpname
            when "2" then
               ewrepm[rth][17]  = row.clientname
            when "3" then

                  ewrepm[rth][17]  = row.employee.name
                  #ewrepm[rth][16]  = "名無しさん"
            
               #ewrepm[rth][16]  = row.employee.name
            else
               ewrepm[rth][17]  = ""
            end

            rth += 1


#debugger # << SumWorkReportクラス def employee_wreport (2)
      end
      # 最終行に各時間帯別作業時間集計値を格納する。
      ewrepm[rth][8]  = totaltimes
      ewrepm[rth][10]  = zone1timesum
      ewrepm[rth][11]  = zone2timesum
      ewrepm[rth][12]  = zone3timesum
      ewrepm[rth][13]  = zone4timesum
      ewrepm[rth][14]  = zone5timesum
      ewrepm[rth][15]  = zone6timesum



#debugger # << SumWorkReportクラス def employee_wreport (3)

      ewrepm # 月間勤務報告書データ配列のリターン

rescue => ex
  print ex.message, "\n"
end

   end   



   def analizewt(timefrom, timeto, bt1, bt2, bt3, bt4, bt5, bt6) # 時間帯別作業時間の分析

#debugger # << SumWorkReportクラス def analizewt (1)
      # 開始時刻および終了時刻が分類される時間帯を調べる。
      stzone = timezone(timefrom, bt1, bt2, bt3, bt4, bt5, bt6)
      etzone = timezone(timeto, bt1, bt2, bt3, bt4, bt5, bt6)
      


      # 時間帯境界時刻のセット
      bdrytime6 = Time.new(bt6.year, bt6.month, bt6.day, bt6.hour, bt6.min, 0) # 深夜１業務境界時刻
      bdrytime5 = Time.new(bt5.year, bt5.month, bt5.day, bt5.hour, bt5.min, 0) # 残業業務境界時刻
      bdrytime4 = Time.new(bt4.year, bt4.month, bt4.day, bt4.hour, bt4.min, 0) # 午後業務境界時刻
      bdrytime3 = Time.new(bt3.year, bt3.month, bt3.day, bt3.hour, bt3.min, 0) # 午前業務境界時刻
      bdrytime2 = Time.new(bt2.year, bt2.month, bt2.day, bt2.hour, bt2.min, 0) # 早朝業務境界時刻
      bdrytime1 = Time.new(bt1.year, bt1.month, bt1.day, bt1.hour, bt1.min, 0) # 深夜２業務境界時刻

      #bdrytime6 = Time.new(2000, 1, 1, 22, 0, 0) # 深夜１業務境界時刻
      #bdrytime5 = Time.new(2000, 1, 1, 17, 0, 0) # 残業業務境界時刻
      #bdrytime4 = Time.new(2000, 1, 1, 12, 0, 0) # 午後業務境界時刻
      #bdrytime3 = Time.new(2000, 1, 1, 8, 0, 0) # 午前業務境界時刻
      #bdrytime2 = Time.new(2000, 1, 1, 3, 0, 0) # 早朝業務境界時刻
      #bdrytime1 = Time.new(2000, 1, 1, 0, 0, 0) # 深夜２業務境界時刻

#debugger # << SumWorkReportクラス def analizewt (2)
      
      # 時間帯別作業時間のリセット
      zone6times = 0.0
      zone5times = 0.0
      zone4times = 0.0
      zone3times = 0.0
      zone2times = 0.0
      zone1times = 0.0

      # 時間帯別作業時間の算定
      case etzone # 作業終了時間帯と開始時間帯の組み合わせによる算定
      when 6
         case stzone
         when 6
            zone6times = (timeto - timefrom)/ 3600.0
         when 5
            zone6times = (timeto - bdrytime6)/ 3600.0
            zone5times = (bdrytime6 - timefrom)/ 3600.0
         when 4
            zone6times = (timeto - bdrytime6)/ 3600.0
            zone5times = (bdrytime6 - bdrytime5)/ 3600.0
            zone4times = (bdrytime5 - timefrom)/ 3600.0
         when 3
            zone6times = (timeto - bdrytime6)/ 3600.0
            zone5times = (bdrytime6 - bdrytime5)/ 3600.0
            zone4times = (bdrytime5 - bdrytime4)/ 3600.0
            zone3times = (bdrytime4 - timefrom)/ 3600.0
         when 2
            zone6times = (timeto - bdrytime6)/ 3600.0
            zone5times = (bdrytime6 - bdrytime5)/ 3600.0
            zone4times = (bdrytime5 - bdrytime4)/ 3600.0
            zone3times = (bdrytime4 - bdrytime3)/ 3600.0
            zone2times = (bdrytime3 - timefrom)/ 3600.0
         when 1
            zone6times = (timeto - bdrytime6)/ 3600.0
            zone5times = (bdrytime6 - bdrytime5)/ 3600.0
            zone4times = (bdrytime5 - bdrytime4)/ 3600.0
            zone3times = (bdrytime4 - bdrytime3)/ 3600.0
            zone2times = (bdrytime3 - bdrytime2)/ 3600.0
            zone1times = (bdrytime3 - timefrom)/ 3600.0
         end

      when 5
         case stzone
         when 5
            zone5times = (timeto - timefrom)/ 3600.0
         when 4
            zone5times = (timeto - bdrytime5)/ 3600.0
            zone4times = (bdrytime5 - timefrom)/ 3600.0
         when 3
            zone5times = (timeto - bdrytime5)/ 3600.0
            zone4times = (bdrytime5 - bdrytime4)/ 3600.0
            zone3times = (bdrytime4 - timefrom)/ 3600.0
         when 2
            zone5times = (timeto - bdrytime5)/ 3600.0
            zone4times = (bdrytime5 - bdrytime4)/ 3600.0
            zone3times = (bdrytime4 - bdrytime3)/ 3600.0
            zone2times = (bdrytime3 - timefrom)/ 3600.0
         when 1
            zone5times = (timeto - bdrytime5)/ 3600.0
            zone4times = (bdrytime5 - bdrytime4)/ 3600.0
            zone3times = (bdrytime4 - bdrytime3)/ 3600.0
            zone2times = (bdrytime3 - bdrytime2)/ 3600.0
            zone1times = (bdrytime2 - timefrom)/ 3600.0
         end

      when 4
         case stzone
         when 4
            zone4times = (timeto - timefrom)/ 3600.0
         when 3
            zone4times = (timeto - bdrytime4)/ 3600.0
            zone3times = (bdrytime4 - timefrom)/ 3600.0
         when 2
            zone4times = (timeto - bdrytime4)/ 3600.0
            zone3times = (bdrytime4 - bdrytime3)/ 3600.0
            zone2times = (bdrytime3 - timefrom)/ 3600.0
         when 1
            zone4times = (timeto - bdrytime4)/ 3600.0
            zone3times = (bdrytime4 - bdrytime3)/ 3600.0
            zone2times = (bdrytime3 - bdrytime2)/ 3600.0
            zone1times = (bdrytime2 - timefrom)/ 3600.0
         end

      when 3
         case stzone
         when 3
            zone3times = (timeto - timefrom)/ 3600.0
         when 2
            zone3times = (timeto - bdrytime3)/ 3600.0
            zone2times = (bdrytime3 - timefrom)/ 3600.0
         when 1
            zone3times = (timeto - bdrytime3)/ 3600.0
            zone2times = (bdrytime3 - bdrytime2)/ 3600.0
            zone1times = (bdrytime2 - timefrom)/ 3600.0
         end

      when 2
         case stzone
         when 2
            zone2times = (timeto - timefrom)/ 3600.0
         when 1
            zone2times = (timeto - bdrytime2)/ 3600.0
            zone1times = (bdrytime2 - timefrom)/ 3600.0
         end

      when 1
            zone1times = (timeto - timefrom)/ 3600.0
      end

#debugger # << SumWorkReportクラス def analizewt (3)
      
      return zone1times, zone2times, zone3times, zone4times, zone5times, zone6times
   end


   def timezone (time, bt1, bt2, bt3, bt4, bt5, bt6)
#debugger # << SumWorkReportクラス def timezone (1)
      # 時間帯境界時刻のセット
      bdrytime6 = Time.new(bt6.year, bt6.month, bt6.day, bt6.hour, bt6.min, 0) # 深夜１業務境界時刻
      bdrytime5 = Time.new(bt5.year, bt5.month, bt5.day, bt5.hour, bt5.min, 0) # 残業業務境界時刻
      bdrytime4 = Time.new(bt4.year, bt4.month, bt4.day, bt4.hour, bt4.min, 0) # 午後業務境界時刻
      bdrytime3 = Time.new(bt3.year, bt3.month, bt3.day, bt3.hour, bt3.min, 0) # 午前業務境界時刻
      bdrytime2 = Time.new(bt2.year, bt2.month, bt2.day, bt2.hour, bt2.min, 0) # 早朝業務境界時刻
      bdrytime1 = Time.new(bt1.year, bt1.month, bt1.day, bt1.hour, bt1.min, 0) # 深夜２業務境界時刻

      #bdrytime6 = Time.new(2000, 1, 1, 22, 0, 0) # 深夜１業務境界時刻
      #bdrytime5 = Time.new(2000, 1, 1, 17, 0, 0) # 残業業務境界時刻
      #bdrytime4 = Time.new(2000, 1, 1, 12, 0, 0) # 午後業務境界時刻
      #bdrytime3 = Time.new(2000, 1, 1, 8, 0, 0) # 午前業務境界時刻
      #bdrytime2 = Time.new(2000, 1, 1, 3, 0, 0) # 早朝業務境界時刻
      #bdrytime1 = Time.new(2000, 1, 1, 0, 0, 0) # 深夜２業務境界時刻

      #case time
      if time >= bdrytime1 && time < bdrytime2
         tzome = 1
      elsif time >= bdrytime2 && time < bdrytime3
         tzone = 2
      elsif time >= bdrytime3 && time < bdrytime4
         tzone = 3
      elsif time >= bdrytime4 && time < bdrytime5
         tzone = 4
      elsif time >= bdrytime5 && time < bdrytime6
         tzone = 5
      elsif time >= bdrytime6
         tzone = 6
      end

#debugger # << SumWorkReportクラス def timezone (2)

      tzone
   end



   def work_headcount  # 勤務者のプロジェクトべ別出面集計表を作成する。
#debugger # << SumWorkReportクラス def work_headcount (1)

begin

      # 出面集計用4次元ハッシュ配列の作成
      headcount = Hash.new{|hash, key| hash[key] = Hash.new{|hash, key| hash[key] = Hash.new{|hash, key| hash[key] = {} }}}


      height = self.workreports.size + 1
      width = 9 + 9
      hcsource = Array.new(height).map!{ Array.new(width,0)}

      zonetimes = []

#debugger # << SumWorkReportクラス def work_headcount (1.5)

      # 時間帯別作業時間集計値のリセット
      totaltimes = 0.0
      zone6timesum = 0.0
      zone5timesum = 0.0
      zone4timesum = 0.0
      zone3timesum = 0.0
      zone2timesum = 0.0
      zone1timesum = 0.0

      rth = 0

      # 勤務情報開始日付および最終日付のリセット
      stworkdate = Date.new(2099,12,31)
      endworkdate = Date.new(2000,1,1)

#debugger # << SumWorkReportクラス def work_headcount (1.53)

      self.workreports.each do |row|
#print rth
            # 勤務情報開始日付および最終日付のセット
            if row.workdate > endworkdate then
               endworkdate = row.workdate
            end
            if row.workdate < stworkdate then
               stworkdate = row.workdate
            end

            ##hcsource[rth][0]  = row.employee_id
            hcsource[rth][1]  = row.workdate
            hcsource[rth][2]  = row.project.prjname
            hcsource[rth][3]  = row.jobplace.jobplacename
            hcsource[rth][4]  = row.grade.gradename
            ##hcsource[rth][5]  = row.jobitem.jobname
            ##hcsource[rth][6]  = row.timefrom
            ##hcsource[rth][7]  = row.timeto

#debugger # << SumWorkReportクラス def work_headcount (1.54)


            hcsource[rth][8]  = (row.timeto - row.timefrom)/3600.0
               ##totaltimes = totaltimes + hcsource[rth][8]
            ##hcsource[rth][9]  = row.addcomment.comment
            
            # この勤務作業プロジェクトの対象勤務時間帯を設定する。
            splittime_id = row.project.splittime_id
            @splittime = self.splittimes.find{|elem| elem.id == splittime_id}
            
            bt1 = @splittime.splittime1
            bt2 = @splittime.splittime2
            bt3 = @splittime.splittime3
            bt4 = @splittime.splittime4
            bt5 = @splittime.splittime5
            bt6 = @splittime.splittime6

#debugger # << SumWorkReportクラス def work_headcount (1.55)

            # 作業開始終了時刻から各時間帯別作業時間を算出する。
            zonetimes = analizewt(row.timefrom, row.timeto, bt1, bt2, bt3, bt4, bt5, bt6)
            
            ##hcsource[rth][10]  = zonetimes[0]
              ##zone1timesum = zone1timesum + zonetimes[0]
            ##hcsource[rth][11]  = zonetimes[1]
              ##zone2timesum = zone2timesum + zonetimes[1]
            ##hcsource[rth][12]  = zonetimes[2]
              ##zone3timesum = zone3timesum + zonetimes[2]
            ##hcsource[rth][13]  = zonetimes[3]
              ##zone4timesum = zone4timesum + zonetimes[3]
            ##hcsource[rth][14]  = zonetimes[4]
              ##zone5timesum = zone5timesum + zonetimes[4]
            ##hcsource[rth][15]  = zonetimes[5]
              ##zone6timesum = zone6timesum + zonetimes[5]

            # 勤務者と所属部門／顧客名称を格納する

#debugger # << SumWorkReportクラス def work_headcount (1.6)


               ##hcsource[rth][16]  = row.employee.name
               
            

            case self.sammarycd
            when "1" then
               ##hcsource[rth][17]  = row.dpname
            when "2" then
               ##hcsource[rth][17]  = row.clientname
            when "3" then

                  ##hcsource[rth][17]  = row.employee.name
                  
            
            
            else
               ##hcsource[rth][17]  = ""
            end


#debugger # << SumWorkReportクラス def work_headcount (1.7)

            # 出面集計用4次元ハッシュ配列に出面人工数を累計する。
            #  格納先ハッシュkeyの設定
            hproject = row.project.prjname
            hjobplace = row.jobplace.jobplacename
            hgrade = row.grade.gradename
            hymd = row.workdate.year.to_s << "N" << row.workdate.month.to_s << "G" << row.workdate.day.to_s

            # 人工（一日の実働時間）を設定
            bdrytime5 = Time.new(bt5.year, bt5.month, bt5.day, bt5.hour, bt5.min, 0) # 残業業務境界時刻
            bdrytime3 = Time.new(bt3.year, bt3.month, bt3.day, bt3.hour, bt3.min, 0) # 午前業務境界時刻
            unitheadcount = (bdrytime5 - bdrytime3)/3600.0 -1.0 # 休憩1時間分差引く

            # 換算人工の設定（但し、残業時間帯による割増は考慮せず）
            vheadcount = (row.timeto - row.timefrom)/3600.0/unitheadcount

#debugger # << SumWorkReportクラス def work_headcount (1.8)

            # 出面集計用ハッシュ配列に出面人工数を累計する
            if headcount[hproject][hjobplace][hgrade][hymd] then
               headcount[hproject][hjobplace][hgrade][hymd] = headcount[hproject][hjobplace][hgrade][hymd] + vheadcount

#debugger # << SumWorkReportクラス def work_headcount (1.9)

            else
               headcount[hproject][hjobplace][hgrade][hymd] = vheadcount
            end

#debugger # << SumWorkReportクラス def work_headcount (1.10)

# -------------------------------------------------------
            rth += 1


#debugger # << SumWorkReportクラス def work_headcount (2)
      end
      # 最終行に各時間帯別作業時間集計値を格納する。
      ##hcsource[rth][8]  = totaltimes
      ##hcsource[rth][10]  = zone1timesum
      ##hcsource[rth][11]  = zone2timesum
      ##hcsource[rth][12]  = zone3timesum
      ##hcsource[rth][13]  = zone4timesum
      ##hcsource[rth][14]  = zone5timesum
      ##hcsource[rth][15]  = zone6timesum


      # 開始および終了日時をDateに変換する
      #styear = stworkdate.year
      #stmonth = stworkdate.month
      #stday = stworkdate.day
      stdate = Date.new(stworkdate.year, stworkdate.month, stworkdate.day)

      #endyear = endworkdate.year
      #endmonth = endworkdate.month
      #endday = endworkdate.day
      enddate = Date.new(endworkdate.year, endworkdate.month, endworkdate.day)


      # 集計ハッシュのサイズを確認する。
      h1 = 0
      h2 = 0
      h3 = 0
      h4 = 0
      headcount.keys.each do |key1|
         h1 = h1 + 1
         headcount[key1].keys.each do |key2|
            h2 = h2 + 1
            headcount[key1][key2].keys.each do |key3|
               h3 = h3 + 1
               headcount[key1][key2][key3].keys.each do |key4|
                  h4 = h4 + 1
                  p "[#{key1}]{[#{key2}][#{key3}][#{key4}]=#{headcount[key1][key2][key3][key4]}"

               end
            end
         end
      end
      p "h1, h2, h3, h4 maxhn = #{h1},#{h2},#{h3},#{h4},#{[h1, h2, h3, h4].max}"



      # 出面集計表格納配列の確保
      arhch = h3 + 1 + 1 # 最終行（小計行）を追加
      arhcw = 3 + (enddate - stdate).to_i + 1 + 1 # 行末尾の合計セルも追加
      arrayhcounts =  Array.new(arhch).map!{ Array.new(arhcw,0)}

      p "出面表配列サイズ：arhch, arhcw = #{arhch}, #{arhcw}"

      # 出面集計表セルタイトルの埋め込み
      arrayhcounts[0][0] = "プロジェクト名称"
      arrayhcounts[0][1] = "勤務場所"
      arrayhcounts[0][2] = "職能種"

      # 出面集計表の日付行の作成
      for nday in 1..arhcw - 3 do
         coldate = stdate + (nday - 1)
         arrayhcounts[0][3 + nday -1] = nengappi(coldate)
      end

      # 集計ハッシュから出面集計表へのキーおよび値の埋め込み処理
      h1 = 0
      h2 = 0
      h3 = 0
      h4 = 0
      headcount.keys.each do |key1|
         h1 = h1 + 1
         headcount[key1].keys.each do |key2|
            h2 = h2 + 1
            headcount[key1][key2].keys.each do |key3|
               h3 = h3 + 1
               headcount[key1][key2][key3].keys.each do |key4|
                  h4 = h4 + 1
                  p "[#{key1}]{[#{key2}][#{key3}][#{key4}]=#{headcount[key1][key2][key3][key4]}"

                  # 出面タイトル行への各出面集計区分タイトルの埋め込み
                  arrayhcounts[h3][0] = key1
                  arrayhcounts[h3][1] = key2
                  arrayhcounts[h3][2] = key3
                  # 日付カレンダー位置のセット
                  key4date = reversedate (key4)
                  offsetdate = key4date - stdate

                  #print offsetdate
                  
                  # 対応する日付セルへの出面人工数の埋め込み
                  hcvalue = headcount[key1][key2][key3][key4]

                  arrayhcounts[h3][3 + offsetdate] = hcvalue

               end
            end
         end
      end


#debugger # << SumWorkReportクラス def work_headcount (2.5)

      # 出面各行の末尾セルに行出面合計値を格納する
      # 小計タイトル
      arrayhcounts[0][arhcw - 1] = "小計"
      # 集計値算出

      # 最終小計行各セルのリセット
      for col in 3..arhcw -2 do
         arrayhcounts[arhch - 1][col] = 0.0
      end
      # 総累計値のリセット
      totalhc = 0.0
      # 最終小計行タイトルのセット
      arrayhcounts[arhch - 1][0] = ""
      arrayhcounts[arhch - 1][1] = ""
      arrayhcounts[arhch - 1][2] = "小計："


      # 
      for row in 1..arhch - 2 do
         rowsum = 0.0
         for col in 3..arhcw - 2 do
            # row-th行各セルの小計累計（横方向累計）
            rowsum = rowsum + arrayhcounts[row][col]
            # 各日付毎の小計累計（縦方向累計）
            arrayhcounts[arhch - 1][col] = arrayhcounts[arhch - 1][col] + arrayhcounts[row][col]
         end
         arrayhcounts[row][arhcw - 1] = rowsum
         totalhc = totalhc + rowsum
      end
         # 総累計値の格納
         arrayhcounts[arhch - 1][arhcw - 1] = totalhc

#debugger # << SumWorkReportクラス def work_headcount (3)

      arrayhcounts # 月間勤務報告書データ配列のリターン



rescue => ex

#debugger # << SumWorkReportクラス def work_headcount (4)

  print ex.message, "\n"
end

   end 


  private
  def reversedate (datekey) # 日付キー文字列を元の日付データに戻す
     # datekeyの例："2014N5G23"
     
     # 文字数
     textlength = datekey.length
     # "G"の位置
     pstnG = datekey.index(/G/)
     # 年の抽出
     kyear = datekey[0,4].to_i
     # 月の抽出
     kmonth = datekey[5,pstnG-1].to_i
     # 日の抽出
     kday = datekey[pstnG+1,textlength].to_i
     # 元の日付に戻す
     keydate = Date.new(kyear, kmonth, kday)

     keydate
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