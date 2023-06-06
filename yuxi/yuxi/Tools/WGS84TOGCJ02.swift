//
//  WGS84TOGCJ02.swift
//  yuxi
//
//  Created by 申修智 on 2023/5/30.
//

import Foundation
import CoreLocation

    var a = 6378245.0
    var ee = 0.00669342162296594323
    var pi = 3.14159265358979324

    func transformFromWGSToGCJ(wgsLoc:CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        var adjustLoc = CLLocationCoordinate2D()
        if Tools.isLocationOutOfChina(location: wgsLoc) {
            adjustLoc = wgsLoc
        }else {
            var adjustLat = transformLatWithX(x: wgsLoc.longitude - 105.0, y: wgsLoc.latitude - 35.0)
            var adjustLon = transformLonWithX(x: wgsLoc.longitude - 105.0, y: wgsLoc.latitude - 35.0)
            let radLat = wgsLoc.latitude / 180.0 * pi;
            var magic = sin(radLat);
            magic = 1 - ee * magic * magic;
            let sqrtMagic = sqrt(magic);
            adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
            adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
            adjustLoc.latitude = wgsLoc.latitude + adjustLat;
            adjustLoc.longitude = wgsLoc.longitude + adjustLon;
        }
        return adjustLoc
    }
 
    

    func transformLatWithX(x:Double,y:Double) -> Double {
        var lat = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(abs(x))
        lat += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0
        lat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0
        lat += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0
        return lat
    }

    func transformLonWithX(x:Double,y:Double) -> Double {
        var lon = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(abs(x))
        let a = sin(6.0 * x * pi)
        let b = sin(2.0 * x * pi)
        let c = 20.0 * a + 20.0 * b
        lon += c * 2.0 / 3.0
        let d = sin(x * pi)
        let e = sin(x / 3.0 * pi)
        let f = 20.0 * d + 40.0 * e
        lon += f * 2.0 / 3.0
        let r = sin(x / 12.0 * pi)
        let s = sin(x / 30.0 * pi)
        let t = 150.0 * r + 300.0 * s
        lon += t * 2.0 / 3.0
        return lon
    }
