//
//  Network.swift
//  kite
//
//  Created by virl on 2019/3/24.
//  Copyright © 2019 virl. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class KResponse {
    var jsonData: JSON? = nil;
    let dataResponse: Alamofire.DataResponse<Data>;
    init(res:Alamofire.DataResponse<Data>) {
        self.dataResponse = res;
        if(dataResponse.data != nil) {
            do {
                jsonData = try JSON(data: dataResponse.data!)
            } catch {
                
            }
        }
    }
    
    public var httpStatusCode: NSInteger {
        let code = dataResponse.response?.statusCode
        if(code == nil) {
            return -1;
        }
        return code!;
    }
    
}

typealias NetworkCallback = (KResponse) -> Void;


class KiteNetwork {
    public static func httpInternal(_ path:String, method: Alamofire.HTTPMethod, queryParameterst:Parameters?=nil, body:Parameters?=nil, callback:NetworkCallback?=nil) -> Alamofire.DataRequest {
//        临时实现后续继续填充
        return Alamofire.AF.request(path);
    }
    
    public static func internalPost(_ path:String, queryParameterst:Parameters?=nil, body:Parameters?=nil, callback:NetworkCallback?=nil) -> Alamofire.DataRequest {
        return KiteNetwork.httpInternal(path, method: .post, queryParameterst:queryParameterst, body:body, callback:callback);
    }
    
    public static func internalPut(_ path:String, queryParameterst:Parameters?=nil, body:Parameters?=nil, callback:NetworkCallback?=nil) -> Alamofire.DataRequest {
        return KiteNetwork.httpInternal(path, method: .put, queryParameterst:queryParameterst, body:body, callback:callback);
    }
    
    public static func internalGet(_ path:String, queryParameterst:Parameters?=nil, callback:NetworkCallback?=nil) -> Alamofire.DataRequest {
        return KiteNetwork.httpInternal(path, method: .get, queryParameterst:queryParameterst, callback:callback);
    }
    
    public static func internalDelete(_ path:String, queryParameterst:Parameters?=nil, callback:NetworkCallback?=nil) -> Alamofire.DataRequest {
        return KiteNetwork.httpInternal(path, method: .delete, queryParameterst:queryParameterst, callback:callback);
    }
}
