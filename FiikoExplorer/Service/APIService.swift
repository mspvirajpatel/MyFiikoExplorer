//
//  APIService.swift
//  FiikoExplorer
//
//  Created by Viraj on 03/04/17.
//  Copyright © 2017 Viraj. All rights reserved.
//

import UIKit
import SwiftyJSON

class APIService: NSObject {
  
  class func getFlickPosts(search:String, page:Int, photosPerPage:Int, handler: @escaping (_ json: [String: Any]) -> ()) {
    let urlFlick = String(format:Constants.flickPostsURL, search, String(page), String(photosPerPage))
    AFAdapter.GET(urlString:urlFlick, handler: handler)
  }
  
}
