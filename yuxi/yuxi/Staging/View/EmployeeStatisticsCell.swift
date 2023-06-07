//
//  EmployeeStatisticsCell.swift
//  yuxi
//
//  Created by 申修智 on 2023/4/30.
//

import UIKit
import Charts

class EmployeeStatisticsCell: UITableViewCell {
    
    var bgView = UIView()
    var titleLab = UILabel()
    var lineView = UIView()
    
    var chartsView = PieChartView()
    
    
    var unitsSold = [30.0, 100.0, 108.0, 60.0, 50.0]
    var dataArr = ["初中","高中","大专","本科","研究生及以上"]
    
    var model:EmployeeStaisticsModel!{
        didSet {
            if model.age.count != 0 {
                setChart(dataPoints: model.age, values: model.list)
            }else if model.edu.count != 0 {
                setChart(dataPoints: model.edu, values: model.list)
            }else if model.spe.count != 0 {
                setChart(dataPoints: model.spe, values: model.list)
            }else if model.dut.count != 0 {
                setChart(dataPoints: model.dut, values: model.list)
            }
            titleLab.text = model.title
        }
    }
    
    var colorArr:[UIColor] = [YUXICOLOR(h: 0xEB2B2B, alpha: 0.5),YUXICOLOR(h: 0xEB662B, alpha: 1),YUXICOLOR(h: 0xEB982B, alpha: 1),YUXICOLOR(h: 0xEBEB2B, alpha: 1),YUXICOLOR(h: 0x9EEB2B, alpha: 1),YUXICOLOR(h: 0x2BEB4B, alpha: 1),YUXICOLOR(h: 0x2BEBAA, alpha: 1),YUXICOLOR(h: 0x2BB0EB, alpha: 2),YUXICOLOR(h: 0x2B65EB, alpha: 1),YUXICOLOR(h: 0x712BEB, alpha: 1),YUXICOLOR(h: 0xA52BEB, alpha: 1),YUXICOLOR(h: 0xC62BEB, alpha: 1),YUXICOLOR(h: 0xEB2BC5, alpha: 1),YUXICOLOR(h: 0xEB2B6C, alpha: 1)]
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInterface() {
        
        self.contentView.backgroundColor = YUXICOLOR(h: 0x000000, alpha: 0.1)
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = CGFloat(10*YUXIIPONE_SCALE)
        bgView.layer.shadowColor = YUXICOLOR(h: 0x9577FF, alpha: 0.3).cgColor//设置阴影的颜色
        bgView.layer.shadowOpacity = 1//设置阴影的透明度
        bgView.layer.shadowOffset = CGSize.init(width: 0, height: 2) //设置阴影的偏移量
        bgView.layer.shadowRadius = CGFloat(5 * YUXIIPONE_SCALE);//设置阴影的圆角
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10*YUXIIPONE_SCALE)
            make.right.equalToSuperview().offset(-10*YUXIIPONE_SCALE)
            make.height.equalTo(281*YUXIIPONE_SCALE)
        }
        
        
        titleLab.textColor = YUXICOLOR(h: 0x333333, alpha: 1)
        titleLab.font = UIFont.fontWith(.Semibold, size: 16)
        bgView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20*YUXIIPONE_SCALE)
//            make.width.equalTo(WIDTH_SCALE(68))
        }
        
        lineView.backgroundColor = YUXICOLOR(h: 0x3FA9F5, alpha: 1)
        bgView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.height.equalTo(2*YUXIIPONE_SCALE)
            make.left.equalTo(titleLab.snp.left).offset(WIDTH_SCALE(-1))
            make.right.equalTo(titleLab.snp.right).offset(WIDTH_SCALE(1))
            make.top.equalTo(titleLab.snp.bottom).offset(0*YUXIIPONE_SCALE)
        }
        
        chartsView.drawHoleEnabled = false
        bgView.addSubview(self.chartsView)
        chartsView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom)
            make.bottom.equalToSuperview().offset(-10*YUXIIPONE_SCALE)
        }
        
        
        
        setDrawHoleState()
        
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        let  dataEntries = (0..<dataPoints.count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: values[i],
                                     label: dataPoints[i])
        }
        let chartDataSet = PieChartDataSet(entries: dataEntries,
                                           label: "")
        var colors:[UIColor] = []
        if colorArr.count >= dataPoints.count {
            for index in 0..<dataPoints.count {
                colors.append(colorArr[index])
            }
        }else {
            colors = colorArr
        }
        chartDataSet.colors = colors
//        chartDataSet.colors = ChartColorTemplates.vordiplom()
//        + ChartColorTemplates.joyful()
//        + ChartColorTemplates.colorful()
//        + ChartColorTemplates.liberty()
//        + ChartColorTemplates.pastel()
        let chartData = PieChartData(dataSet: chartDataSet)
        
        
        //设置饼状图字体配置
        setPieChartDataSetConfig(pichartDataSet: chartDataSet)
        
        
        let pieChartData = PieChartData(dataSet: chartDataSet)
        //设置饼状图字体样式
        setPieChartDataConfig(pieChartData: pieChartData)
        chartsView.data = chartData //将配置及数据添加到表中
    }
    
    
    //设置饼状图字体配置
    func setPieChartDataSetConfig(pichartDataSet: PieChartDataSet){
        pichartDataSet.sliceSpace = 0 //相邻区块之间的间距
        pichartDataSet.selectionShift = 8 //选中区块时, 放大的半径
        pichartDataSet.xValuePosition = .insideSlice //名称位置
        pichartDataSet.yValuePosition = .outsideSlice //数据位置
        //数据与区块之间的用于指示的折线样式
        pichartDataSet.valueLinePart1OffsetPercentage = 0.85 //折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
        pichartDataSet.valueLinePart1Length = 0.5 //折线中第一段长度占比
        pichartDataSet.valueLinePart2Length = 0.4 //折线中第二段长度最大占比
        pichartDataSet.valueLineWidth = 1 //折线的粗细
        pichartDataSet.valueLineColor = UIColor.gray //折线颜色
        
        
    }
    
    //设置饼状图字体样式
    func setPieChartDataConfig(pieChartData: PieChartData){
//        pieChartData.setValueFormatter(DigitValueFormatter())//设置百分比
        
        pieChartData.setValueTextColor(YUXICOLOR(h: 0x333333, alpha: 1)) //字体颜色
        pieChartData.setValueFont(UIFont.systemFont(ofSize: 10))//字体大小
    }
    
    
    //设置饼状图中心文本
    func setDrawHoleState(){
        ///饼状图距离边缘的间隙
        chartsView.setExtraOffsets(left: 20*CGFloat(YUXIIPONE_SCALE), top: 10*CGFloat(YUXIIPONE_SCALE), right: 20*CGFloat(YUXIIPONE_SCALE), bottom: 0)
        //拖拽饼状图后是否有惯性效果
        chartsView.dragDecelerationEnabled = true
        //是否显示区块文本
        chartsView.drawSlicesUnderHoleEnabled = true
        //是否根据所提供的数据, 将显示数据转换为百分比格式
        chartsView.usePercentValuesEnabled = false

        // 设置饼状图描述
//        chartsView.chartDescription.text = "饼状年龄库图示例"
//        chartsView.chartDescription.font = UIFont.systemFont(ofSize: 10)
//        chartsView.chartDescription.textColor = UIColor.gray
        
        // 设置饼状图图例样式
        chartsView.legend.maxSizePercent = 1 //图例在饼状图中的大小占比, 这会影响图例的宽高
        chartsView.legend.formToTextSpace = 5 //文本间隔
        chartsView.legend.font = UIFont.systemFont(ofSize: 10) //字体大小
        chartsView.legend.textColor = YUXICOLOR(h: 0x333333, alpha: 1) //字体颜色
        chartsView.legend.verticalAlignment = .bottom //图例在饼状图中的位置
        chartsView.legend.form = .circle //图示样式: 方形、线条、圆形
        chartsView.legend.formSize = 12 //图示大小
        chartsView.legend.orientation = .horizontal
        chartsView.legend.horizontalAlignment = .center
        chartsView.legend.drawInside = false
        
//        pieChartView.centerText = "平均库龄" //饼状图中心的文本
        ////饼状图中心的富文本文本
//        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(15.0)), NSAttributedString.Key.foregroundColor: UIColor.gray]
//        let centerTextAttribute = NSAttributedString(string: "平均库龄", attributes: attributes)
//        chartsView.centerAttributedText = centerTextAttribute



        /*
        ///设置饼状图中心的文本
        if pieChartView.isDrawHoleEnabled {
        ///设置饼状图中间的空心样式
            pieChartView.drawHoleEnabled = true //饼状图是否是空心
            pieChartView.holeRadiusPercent = 0.5 //空心半径占比
            pieChartView.holeColor = UIColor.clear //空心颜色
            pieChartView.transparentCircleRadiusPercent = 0.52 //半透明空心半径占比
            pieChartView.transparentCircleColor = UIColor(r: 210, g: 145, b: 165, 0.3) //半透明空心的颜色
            pieChartView.drawCenterTextEnabled = true //是否显示中间文字
            //普通文本
            //pieChartView.centerText = "平均库龄"
            //富文本
            let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: CGFloat(15.0)), NSForegroundColorAttributeName: UIColor.red]
            let centerTextAttribute = NSAttributedString(string: "平均库龄", attributes: attributes)
            pieChartView.centerAttributedText = centerTextAttribute
        }
         */
        
        chartsView.setNeedsDisplay()


    }
    
    
}


class DigitValueFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let valueWithoutDecimalPart = String(format: "%.0f", value)
        return valueWithoutDecimalPart

    }
}
