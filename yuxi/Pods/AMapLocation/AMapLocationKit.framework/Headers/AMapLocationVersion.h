//
//  AMapLoctionVersion.h
//  AMapLocationKit
//
//  Created by AutoNavi on 16/1/22.
//  Copyright © 2016年 Amap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapFoundationKit/AMapFoundationVersion.h>

#ifndef AMapLoctionVersion_h
#define AMapLoctionVersion_h

#define AMapLocationVersionNumber                   201000
#define AMapLocationFoundationVersionMinRequired    10700

// 依赖库版本检测
#if AMapFoundationVersionNumber < AMapLocationFoundationVersionMinRequired
#error "The AMapFoundationKit version is less than minimum required, please update! Any questions please to visit http://lbs.amap.com"
#endif

FOUNDATION_EXTERN NSString * const AMapLocationVersion;
FOUNDATION_EXTERN NSString * const AMapLocationName;

#endif /* AMapLoctionVersion_h */
