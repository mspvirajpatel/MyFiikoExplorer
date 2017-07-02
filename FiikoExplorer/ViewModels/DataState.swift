//
//  DataState.swift
//  FiikoExplorer
//
//  Created by Viraj on 03/04/17.
//  Copyright © 2017 Viraj. All rights reserved.
//


import UIKit

//
// This is a class to store the App State.
// Set by Data Store / Network, pushes data into VMs
//

//  MARK: DataStateItems
@objc protocol DataStateProtocol {
  @objc optional func updateFlick(posts:[FlickPost])
  @objc optional func updateFlickHorizontal(posts:[FlickPost], type:FlickrPostType.RawValue)
}

class DataStateItems : NSObject {
  static let sharedInstance = DataStateItems()
  private var delegates : [DataStateProtocol] = []
  var delegate : DataStateProtocol? = nil {
    didSet {
      delegates.append(delegate!)
    }
  }
  // Insta
 
  // Flick
  var flickSearchTerm : String = Constants.defaultFlickSearchTerm
  var flickPage : Int = 1
  var flickPostsPerPage = 30
  var flickPosts : [FlickPost] = [] {
    didSet {
      _ = delegates.flatMap({
        if $0.updateFlick != nil {
          $0.updateFlick!(posts: flickPosts)
        }
      })
    }
  }
  
  // Flick Horizontal
  var dogPosts : [FlickPost] = [] {
    didSet {
      self.didSetHorizontal(posts: dogPosts, type: FlickrPostType.Dogs.rawValue)
    }
  }
  var catPosts : [FlickPost] = [] {
    didSet {
      self.didSetHorizontal(posts: catPosts, type: FlickrPostType.Cats.rawValue)
    }
  }
  var monkeyPosts : [FlickPost] = [] {
    didSet {
      self.didSetHorizontal(posts: monkeyPosts, type: FlickrPostType.Monkeys.rawValue)
    }
  }
  var elephantPosts : [FlickPost] = [] {
    didSet {
      self.didSetHorizontal(posts: elephantPosts, type: FlickrPostType.Elephants.rawValue)
    }
  }
  var lionPosts : [FlickPost] = [] {
    didSet {
      self.didSetHorizontal(posts: lionPosts, type: FlickrPostType.Lions.rawValue)
    }
  }
  var tigerPosts : [FlickPost] = [] {
    didSet {
      self.didSetHorizontal(posts: tigerPosts, type: FlickrPostType.Tigers.rawValue)
    }
  }
  var bearPosts : [FlickPost] = [] {
    didSet {
      self.didSetHorizontal(posts: bearPosts, type: FlickrPostType.Bears.rawValue)
    }
  }
  var ohmyPosts : [FlickPost] = [] {
    didSet {
      self.didSetHorizontal(posts: ohmyPosts, type: FlickrPostType.OhMy.rawValue)
    }
  }
  
  func didSetHorizontal(posts:[FlickPost], type:FlickrPostType.RawValue) {
    _ = delegates.flatMap({
      if $0.updateFlickHorizontal != nil {
        $0.updateFlickHorizontal!(posts: posts, type:type)
      }
    })
  }
}

