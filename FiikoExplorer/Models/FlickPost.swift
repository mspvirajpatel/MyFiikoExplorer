//
//  FlickPost.swift
//  FiikoExplorer
//
//  Created by Viraj on 03/04/17.
//  Copyright © 2017 Viraj. All rights reserved.
//

import UIKit

class FlickPost : NSObject  {
  dynamic var id                             : String = ""
  dynamic var title                          : String = ""
  dynamic var farm                           : Int = 0
  dynamic var secret                         : String = ""
  dynamic var server                         : String = ""
  var image : String {
    get {
      return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg"
    }
  }
  
  /**
   parse
   Takes a JSON object and pulls out the necessary values.\
   */
  class func parse(json:[String: Any]) -> FlickPost {
    let post : FlickPost = FlickPost()
    
    if let id = json["id"] as? String {
      post.id = id
    }
    
    if let title = json["title"] as? String {
      post.title = title
    }
    
    if let farm = json["farm"] as? Int {
      post.farm = farm
    }
    
    if let server = json["server"] as? String {
      post.server = server
    }
    
    if let secret = json["secret"] as? String {
      post.secret = secret
    }
    
    return post
  }
  
  /**
   parseList
   Takes a JSON Array and parses channel objects, returns a parsed array of Channels
   - parameter json:   JSON [Array]
   - parameter usePNG: Bool
   - returns: [Channel]
   */
  class func parseList(list:Array<Any>) -> [FlickPost] {
    return list.map( {
      if let json = $0 as? [String: Any] {
        return parse(json: json)
      } else {
        return FlickPost()
      }
    }).filter( { $0.id != "" } )
  }
}
