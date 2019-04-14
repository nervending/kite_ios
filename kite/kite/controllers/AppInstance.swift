//
//  AppInstance.swift
//  kite
//
//  Created by virl on 2019/3/24.
//  Copyright © 2019 virl. All rights reserved.
//

import Foundation


class AppInstance {
    static private var _appKV: KiteKV? = nil;
    static private var _kiteDB: KiteDB? = nil;
    static var kv:KiteKV {
        if(_appKV == nil) {
            _appKV = KiteKV(db:AppInstance.kiteBD.appDB, table_name:"app_kv");
        }
        return _appKV!;
    }
    
    static var kiteBD:KiteDB {
        if(_kiteDB == nil) {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            _kiteDB = KiteDB(base_path:path);
        }
        return _kiteDB!;
    }
    
    static func onUserLogin(uid:String) {
        AppInstance.kiteBD.onSwitchToUser(uid: uid);
        UserInstance.onUserLogin(uid: uid);
    }
    
    static func onUserLogout() {
        
    }
}
