//
//  MyAttendanceCalendarView.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/15.
//

import UIKit
import CVCalendar

class MyAttendanceCalendarView: UIView,CVCalendarViewDelegate,CVCalendarMenuViewDelegate  {
    
    var menuView: CVCalendarMenuView!

    var calendarView: CVCalendarView!
    
    var selectDateCallback:((_ date:Date)->())?
    var switchingMonthsClock:((_ year:String, _ month:String)->())?
    
    var calendarArr:[CalendarClockInModel] = []{
        didSet {
            menuView.commitMenuViewUpdate()
            calendarView.commitCalendarViewUpdate()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupInterface() {
        self.menuView = CVCalendarMenuView()
        
        self.menuView.backgroundColor = YUXICOLOR(h: 0xE4E4E4, alpha: 1)
        
        // CVCalendarView initialization with frame
        self.calendarView = CVCalendarView()//(frame: CGRect(x: 0, y: 20, width: 300, height: 450))
        calendarView.backgroundColor = .white
        // Appearance delegate [Unnecessary]
        self.calendarView.calendarAppearanceDelegate = self

        // Animator delegate [Unnecessary]
        self.calendarView.animatorDelegate = self

        // Menu delegate [Required]
        self.menuView.menuViewDelegate = self
        self.menuView.calendar = .autoupdatingCurrent

        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self
        self.addSubview(menuView)
        self.addSubview(calendarView)
        self.calendarView.backgroundColor = .white
        menuView.snp.makeConstraints { make in
            make.height.equalTo(37*YUXIIPONE_SCALE)
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        calendarView.snp.makeConstraints { make in
            make.height.equalTo(255*YUXIIPONE_SCALE)
            make.top.equalTo(menuView.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    
    
    //今天按钮点击
    func todayButtonTapped(_ sender: AnyObject) {
        let today = Date()
        self.calendarView.toggleViewWithDate(today)
    }
    
    
    func presentationMode() -> CalendarMode {
        //使用月视图
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        //导航栏显示当前日历的年月
//        navTitle = date.globalDescription
    }
     
    //每个日期上面是否添加横线(连在一起就形成每行的分隔线)
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
     
    //切换月的时候日历是否自动选择某一天（本月为今天，其它月为第一天）
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
    }
    
    func didShowPreviousMonthView(_ date: Date) {
        print("翻到了上一个月!")
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MM月"
        let month = dformatter.string(from: date)
        print("翻到了上一个月!dformatter === \(month)")
        
        let dformatter2 = DateFormatter()
        dformatter2.dateFormat = "yyyy年"
        let year = dformatter2.string(from: date)
        print("翻到了上一个月!dformatter === \(year)")
        
        if let block = switchingMonthsClock {
            block(year,month)
        }
    }
     
    func didShowNextMonthView(_ date: Date) {
        print("翻到了下一个月!")
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MM月"
        let month = dformatter.string(from: date)
        print("翻到了下一个月!dformatter === \(month)")
        
        let dformatter2 = DateFormatter()
        dformatter2.dateFormat = "yyyy年"
        let year = dformatter2.string(from: date)
        print("翻到了下一个月!dformatter === \(year)")
        
        if let block = switchingMonthsClock {
            block(year,month)
        }
    }
     
    //日期选择响应
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        //获取日期
        let date = dayView.date.convertedDate()!
        
        
        if let block = selectDateCallback {
            block(date)
        }
            
            
    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        let day = dayView.date.day
        var numberofDots = "0"
        for (index,model) in calendarArr.enumerated() {
            if String(day) == model.day {
                numberofDots = calendarArr[index].need
            }
        }
        return numberofDots == "0" ? false : true
//        }
        
    }
    
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
        let day = dayView.date.day
        var numberofDots = ""
        for (index,model) in calendarArr.enumerated() {
            if String(day) == model.day {
                numberofDots = calendarArr[index].status
            }
        }
        switch (numberofDots)
        {
            case "0":
                return [YUXICOLOR(h: 0xF5643F, alpha: 1)]
            case "1":
                return [.blue]
            default:
            return [.clear]
        }
    }
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: DayView) -> Bool {
        return true
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 15
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return false
    }
    
    //标记点的偏移量
    func dotMarker(moveOffsetOnDayView dayView: DayView) -> CGFloat {
        return 12
    }
    
    //星期栏文字显示类型
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .short
    }
    
    
////    添加一个代理方法，用来设置显示在日期上的辅助视图
//    func preliminaryView(view0nDayView dayView: DayView) -> UIView {
//        //初始化一个辅助视图，设置其显示区域和日期视图相同，并且形状为圆形。
//        let circleView = CVAuxiliaryView(dayView: dayView,
//                                         rect: dayView.frame,
//                                         shape: CVShape.circle)
//        //设置辅助视图的填充颜色为浅灰色
//        circleView.fillColor = .colorFromCode(0xCCCCCC)
//        //返回该辅助视图
//        return circleView
//    }
//
//    //添加一个代理方法，用来设置是否允许在日期视图上，显示一个辅助视图
//    func preliminaryView(shouldDisplayOnDayView dayView:DayView)->Bool {
//        //设置当日期视图中的日期为当日的天数时，显示辅助视图，否则不显示
//        if (dayView.isCurrentDay) {
//            return true
//        }
//        //否则不显示
//        return true
//
//    }
    
//    //添加一个代理方法，用来设置在何种情况下，允许显示辅助视图。
//    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
//        //当某处的日期的天数为周五时，在该日期位置显示一个辅助视图，
//        //否则不会显示辅助视图。
////        if (dayView.date.weekDay == Weekday.friday) {
////            return true
////        }
//        return true
//    }

}
