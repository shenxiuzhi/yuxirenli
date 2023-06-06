//
//  URLLogin.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/6.
//

import Foundation


/// 登录相关接口
let YUXI_Login_Url = BASE_Url + "/api/login/"

//登录接口
let Login_login = YUXI_Login_Url + "login" + Suffix_Post

//退出登录
let Url_Login_Out = YUXI_Login_Url + "out" + Suffix_Post

//修改密码
let Login_Passwordn = YUXI_Login_Url + "password" + Suffix_Post

//自动登录
let URL_AutoLogin = YUXI_Login_Url + "autoLogin" + Suffix_Post

