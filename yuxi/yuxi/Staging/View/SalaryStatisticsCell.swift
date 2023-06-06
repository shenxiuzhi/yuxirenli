//
//  SalaryStatisticsCell.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/16.
//

import UIKit
import Charts

class SalaryStatisticsCell: UITableViewCell, ChartViewDelegate {
    
    var titleLab = UILabel()
    
    var barChartView = BarChartView()
    
    var lineView = UIView()
    
    var index:Int = 0
    
    var model = SalarStatisticsListModel() {
        didSet {
            if index == 0 {
                titleLab.text = "基本工资支出对比(单位:\(model.unit))"
                lineView.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
            }else {
                titleLab.text = "奖金支出对比(单位:\(model.unit))"
                lineView.backgroundColor = YUXICOLOR(h: 0xEFC4FE, alpha: 1)
            }
            self.barChartView.xAxis.axisLineColor = YUXICOLOR(h: index == 0 ? 0x3FA9F5:0xEFC4FE, alpha: 1)
//            self.barChartView.xAxis.labelTextColor = YUXICOLOR(h: index == 0 ? 0x3FA9F5:0xEFC4FE, alpha: 1)
            setData(month: model.month, list: model.list)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInterface(){
        let gLine = UIView()
        gLine.backgroundColor = YUXICOLOR(h: 0xE4E4E4, alpha: 1)
        self.contentView.addSubview(gLine)
        gLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(WIDTH_SCALE(18))
            make.top.equalTo(self.contentView.snp.top)
            make.height.equalTo(WIDTH_SCALE(1))
        }
        
        titleLab.text = "基本工资支出对比"
        titleLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        titleLab.font = UIFont.fontWith(.Semibold, size: 16)
        self.contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(WIDTH_SCALE(28))
            make.top.equalToSuperview().offset(WIDTH_SCALE(20))
        }
        
       
        lineView.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.right.equalTo(titleLab)
            make.top.equalTo(titleLab.snp.bottom)
            make.height.equalTo(WIDTH_SCALE(2))
        }
        
        self.barChartView.delegate = self
        self.contentView.addSubview(self.barChartView)
        barChartView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(WIDTH_SCALE(10))
            make.left.equalToSuperview().offset(WIDTH_SCALE(0))
            make.right.equalToSuperview().offset(WIDTH_SCALE(0))
            make.bottom.equalToSuperview().offset(WIDTH_SCALE(-20))
        }
        barChartView.backgroundColor = UIColor.clear
        
        //基本样式
        barChartView.noDataText = "You need to provide data for the chart." //没有数据时的文字提示
        barChartView.drawValueAboveBarEnabled = true  //数值显示在柱形的上面还是下面
        barChartView.drawBarShadowEnabled = false  //是否绘制柱形的阴影背景

        
        //barChartView的交互设置
        self.barChartView.scaleYEnabled = false  //取消Y轴缩放
        self.barChartView.doubleTapToZoomEnabled = false   //取消双击缩放
        self.barChartView.dragEnabled = true  //启用拖拽图表
        self.barChartView.dragDecelerationEnabled = false  //拖拽后是否有惯性效果
        self.barChartView.dragDecelerationFrictionCoef = 0 //拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        
        //设置barChartView的X轴样式
        let xAxis = self.barChartView.xAxis
        xAxis.axisLineWidth = 1  //设置X轴线宽
//        xAxis.axisLineColor = YUXICOLOR(h: 0xAADBFE, alpha: 1)
        xAxis.labelPosition = .bottom  //X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = false   //不绘制网格线
        //xAxis.l = 4  //设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
        xAxis.labelTextColor = YUXICOLOR(h: 0x999999, alpha: 1) //label文字颜色
        xAxis.labelCount = 10
        
        self.barChartView.rightAxis.enabled = false  //不绘制右边轴
        //设置左侧Y轴的样式
        let leftAxis = self.barChartView.leftAxis
        leftAxis.forceLabelsEnabled = false   //不强制绘制制定数量的label
        //leftAxis = false  //是否只显示最大值和最小值
        leftAxis.axisMinimum = 0  //设置Y轴的最小值
        leftAxis.drawZeroLineEnabled = true   //从0开始绘制
        leftAxis.axisMaximum = 105   //设置Y轴的最大值
        leftAxis.inverted = false   //是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0    //Y轴线宽
        leftAxis.axisLineColor =  UIColor.clear  //Y轴颜色
        leftAxis.labelCount = 5
        
        //设置Y轴上标签的样式
        leftAxis.labelPosition = .outsideChart   //label位置
        leftAxis.labelTextColor = UIColor.clear   //文字颜色
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)  //文字字体
        
        //设置Y轴上标签显示数字的格式
        let  leftFormatter = NumberFormatter()  //自定义格式
        leftFormatter.positiveSuffix = "￥"  //数字后缀单位
        leftFormatter.numberStyle = .decimal
        leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: leftFormatter)
        leftAxis.valueFormatter = DefaultAxisValueFormatter(decimals: 2)
        
        //设置Y轴上网格线的样式
        leftAxis.gridLineDashLengths = [0, 0]   //设置虚线样式的网格线
        leftAxis.gridColor = UIColor.clear  //网格线颜色
        leftAxis.gridAntialiasEnabled = false   //开启抗锯齿
        
        let limitLine = ChartLimitLine(limit: 20, label: "")
        limitLine.lineWidth = 2
        limitLine.lineColor = UIColor.clear
        limitLine.lineDashLengths = [0, 0]   //虚线样式
        limitLine.labelPosition = .topRight //位置
//        leftAxis.addLimitLine(limitLine)  //添加到Y轴上
        leftAxis.drawLimitLinesBehindDataEnabled = false  //设置限制线绘制在柱形图的后面
        
        self.barChartView.legend.enabled = false  //不显示图例说明
        self.barChartView.chartDescription?.text = "" //不显示，就设为空字符串即可
        
        
//        setData()
    }
    func setData(month:[String],list:[Int]){
        var xVals = [String]()
        for i in 0...12
        {
            xVals.append(NSString(format: "%d年", i+1993) as String)
        }
        //chartView.xAxis.valueFormatter = KMChartAxisValueFormatter.init(xValues as NSArray)
        
        
        var axisMaximum = 0
        var yVals = [BarChartDataEntry]()
        for j in 0..<month.count
        {
//            let val = (Double)(arc4random_uniform(60))

            yVals.append(BarChartDataEntry.init(x: Double(j+1), y: Double(list[j])))
        }
        for item in list {
            if axisMaximum < item {
                axisMaximum = item
            }
        }
        self.barChartView.leftAxis.axisMaximum = Double(axisMaximum + 1000)
        //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
        let set1 = BarChartDataSet(entries: yVals, label: "$")
        //set1.bar = 0.2  //柱形之间的间隙占整个柱形(柱形+间隙)的比例
        set1.drawValuesEnabled = true  //是否在柱形图上面显示数值
        set1.highlightEnabled = true  //点击选中柱形图是否有高亮效果，（双击空白处取消选中）
        set1.colors = ChartColorTemplates.material()
        
        
        //将BarChartDataSet对象放入数组中
        
        
        var dataSets = [BarChartDataSet]()

        
        dataSets.append(set1)
        
        //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
        
//        self.barChartView.xAxis.valueFormatter = KMChartAxisValueFormatter.init(array: xVals as NSArray) as! IAxisValueFormatter
        
        let data:BarChartData = BarChartData(dataSets: dataSets)
        data.setValueFont(UIFont.fontWith(size: 8))  //文字字体
        data.setValueTextColor(YUXICOLOR(h: index == 0 ? 0x3FA9F5:0xEFC4FE, alpha: 1))  //文字颜色
        data.barWidth = 0.7
        
        //自定义数据显示格式
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        //formatter.positiveFormat = " $"
        self.barChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: formatter)
        
        
        self.barChartView.data = data
        self.barChartView.animate(xAxisDuration: 1)

    }

}
    //点击选中柱形图时的代理方法
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //设置barChartView的X轴样式
        let xAxis = chartView.xAxis
        xAxis.gridColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        xAxis.labelTextColor = YUXICOLOR(h: 0x333333, alpha: 1) //label文字颜色
    }

    //没有选中柱形图时的代理方法
    func chartValueNothingSelected(_ chartView: ChartViewBase){
        let xAxis = chartView.xAxis
        xAxis.gridColor = YUXICOLOR(h: 0xAADBFE, alpha: 1)
        xAxis.labelTextColor = YUXICOLOR(h: 0x999999, alpha: 1) //label文字颜色
        
    }
