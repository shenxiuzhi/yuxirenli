//
//  URLUserInfo.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/15.
//

import Foundation

/// 登录相关接口
let YUXI_User_Url = BASE_Url + "/api/"


//用户数据
let URL_User_Info = YUXI_User_Url + "user/info" + Suffix_Post

//消息列表
let URL_Message_List = YUXI_User_Url + "message/list" + Suffix_Post

//员工薪资详情
let URL_Salary_Info = YUXI_User_Url + "salary/info" + Suffix_Post

//员工按年获取薪资列表
let URL_Salary_GetList = YUXI_User_Url + "salary/getList" + Suffix_Post

//员工打卡详情
let URL_Attendance_Listinfo = YUXI_User_Url + "attendance/listinfo" + Suffix_Post

//打卡日历
let URL_Attendance_GetCalendar = YUXI_User_Url + "attendance/getCalendar" + Suffix_Post

//签到打卡
let URL_Attendance_Punch = YUXI_User_Url + "attendance/punch" + Suffix_Post

//考勤打卡信息
let URL_Attendance_Index = YUXI_User_Url + "attendance/index" + Suffix_Post

//全部已读
let URL_Message_All = YUXI_User_Url + "message/all" + Suffix_Post

//薪资统计
let URL_Gather_Info = YUXI_User_Url + "gather/info" + Suffix_Post

//考勤月报
let URL_Attendance_Month = YUXI_User_Url + "attendance/month" + Suffix_Post

//员工统计
let URL_User_Coun = YUXI_User_Url + "user/coun" + Suffix_Post

//通讯录
let URL_User_Book = YUXI_User_Url + "user/book" + Suffix_Post

//客服电话
let URL_Login_Tel = YUXI_User_Url + "login/tel" + Suffix_Post

//保存设备id
let URL_Login_Saveclient = YUXI_User_Url + "login/saveclient" + Suffix_Post

