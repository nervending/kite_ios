//
//  KiteDB.swift
//  kite
//
//  Created by virl on 2019/3/25.
//  Copyright © 2019 virl. All rights reserved.
//

import Foundation
import SQLite

let kAppDBVersion = 1;
let kUserDBVersion = 2;

class KiteDB {
    init(base_path:String) {
        _basePath = base_path;
        do {
            _appDB = try Connection("\(_basePath)/_app/.sqlite3")
        } catch {
            
        }
    }
    
    private var _appDB: Connection? = nil;
    private var _userDB: Connection? = nil;
    private var _basePath: String;
    
    public var appDB: Connection {
        return _appDB!;
    }
    
    public var userDB: Connection? {
        return _userDB;
    }
    
    public func onSwitchToUser(uid: String) {
        _userDB = nil;
        do {
            _userDB = try Connection("\(_basePath)/_\(uid)/.sqlite3")
        } catch {
            
        }
    }
    
    private func onAppDBNeedUpgrade(oldVersion:Int) {
        
    }
    
    private func onUserDBNeedUpgrade(oldVersion:Int) {
        
    }
    
}
