//
//  KiteKV.swift
//  kite
//
//  Created by virl on 2019/3/25.
//  Copyright © 2019 virl. All rights reserved.
//

import Foundation
import SQLite
import SwiftyJSON


class KiteKV {
    private let table: Table;
    private let db: Connection;
    private let columnKey = Expression<String>("key");
    private let columnValue = Expression<String>("value");
    init(db: Connection, table_name:String) {
        self.table = Table(table_name);
        self.db = db;
    }
    
    public func setup() {
        do {
            try db.run(table.create(ifNotExists: true) { t in
                t.column(columnKey, primaryKey: true)
                t.column(columnValue)
            })
        } catch {
            
        }
    }
    
    public func set(key:String, value:Int64) -> Bool {
        let stringV = String(value);
        return self.set(key: key, value: stringV);
    }
    
    public func set(key:String, value:JSON) -> Bool {
        let stringV = value.rawString()
        if(stringV != nil) {
            return self.set(key: key, value: stringV!);
        }
        return false;
    }
    
    public func set(key:String, value:Float) -> Bool {
        let stringV = String(value);
        return self.set(key: key, value: stringV);
    }
    
    public func set(key:String, value:Double) -> Bool {
        let stringV = String(value);
        return self.set(key: key, value: stringV);
    }
    
    public func set(key:String, value:String) -> Bool {
        do {
            try db.run(table.insert(or: .replace, columnKey <- key, columnValue <- value))
            return true;
        } catch {
        }
        return false;
    }
    
    public func set(key:String, value:Int32) -> Bool {
        let stringV = String(value);
        return self.set(key: key, value: stringV);
    }
    
    public func getInt32(key:String, defultValue:Int32 = 0) -> Int32 {
        let value = self.getString(key: key);
        if(value != nil) {
            return Int32(value!) ?? defultValue;
        }
        return defultValue;
    }
    
    public func getInt64(key:String, defultValue:Int64 = 0) -> Int64 {
        let value = self.getString(key: key);
        if(value != nil) {
            return Int64(value!) ?? defultValue;
        }
        return defultValue;
    }
    
    public func getFloat(key:String, defultValue:Float = 0) -> Float {
        let value = self.getString(key: key);
        if(value != nil) {
            return Float(value!) ?? defultValue;
        }
        return defultValue;
    }
    
    public func getDouble(key:String, defultValue:Double = 0) -> Double {
        let value = self.getString(key: key);
        if(value != nil) {
            return Double(value!) ?? defultValue;
        }
        return defultValue;
    }
    
    public func getString(key:String, defaultValue:String? = nil) -> String? {
        do {
            let filter = table.filter(columnKey == key)
            if let kv = try db.pluck(filter) {
                return kv[columnKey];
            }
            return defaultValue;
        } catch {
            return defaultValue;
        }
    }
    
    public func getJSON(key:String) -> JSON? {
        let value = self.getString(key: key);
        if(value != nil) {
            return JSON(value!) ?? nil;
        }
        return nil;
    }
 
    public func delete(key: String) {
        do {
            let filter = table.filter(columnKey == key)
            try db.run(filter.delete())
        } catch {
            
        }
    }
}
