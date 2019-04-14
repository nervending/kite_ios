//
//  UserInstance.swift
//  kite
//
//  Created by virl on 2019/3/24.
//  Copyright © 2019 virl. All rights reserved.
//

import Foundation


class UserInstance {
    static private var _kv: KiteKV? = nil;
    static var kv:KiteKV? {
        if(_kv == nil) {
            if(AppInstance.kiteBD.userDB != nil) {
                _kv = KiteKV(db:AppInstance.kiteBD.userDB!, table_name:"kv");
            } else {
                return nil;
            }
        }
        return _kv;
    }
    
    static private var _uid:String? = nil;
    
    static var uid:String? {
        return _uid;
    }
    
    static var logined:Bool {
        return _uid != nil;
    }
    
    static func onUserLogin(uid:String) {
        _uid = uid;
    }
    
    static func onUserLogout() {
        _uid = nil;
        _kv = nil;
    }
}
