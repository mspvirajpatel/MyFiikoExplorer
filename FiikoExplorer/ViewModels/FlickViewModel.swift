//
//  FlickViewModel.swift
//  FiikoExplorer
//
//  Created by Viraj on 03/04/17.
//  Copyright © 2017 Viraj. All rights reserved.
//

import UIKit

class FlickViewModel: IFViewModel, DataStateProtocol {
  
  func setup() {
    DataStateItems.sharedInstance.delegate = self
  }
  var loading : Bool = false
  var searchTerm : String {
    get {
      return DataStateItems.sharedInstance.flickSearchTerm
    }
  }
  var page : Int  {
    get {
      return DataStateItems.sharedInstance.flickPage
    }
  }
  var postsPerPage : Int  {
    get {
      return DataStateItems.sharedInstance.flickPostsPerPage
    }
  }
  
  var posts : [FlickPost] {
    get {
      return DataStateItems.sharedInstance.flickPosts
    }
  }
  
  /**
   loadFlickPosts
   Fetch Flick
   */
  func loadFlickPosts() {
    if loading == true { return }
    loading = true
    FlickInterface.getFlickPosts(search:self.searchTerm, page:self.page, photosPerPage:self.postsPerPage)
  }
  
  /**
   refreshFlickPosts
   */
  func refreshFlickPosts() {
    loading = false
    DataStateItems.sharedInstance.flickPage = 1
    self.loadFlickPosts()
  }
  
  /**
   loadNextPage
   Fetch More Flick
   */
  func loadNextPage() {
    if loading == true { return }
    DataStateItems.sharedInstance.flickPage = self.page + 1
    self.loadFlickPosts()
  }
  
  /**
   changeSearchTerm
   - parameter searchTerm: String
   */
  func changeSearchTerm(searchTerm: String) {
    loading = false
    DataStateItems.sharedInstance.flickPage = 1
    DataStateItems.sharedInstance.flickSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
    loadFlickPosts()
  }
  
  //  MARK: CurrentFlickProtocol Delegate Methods
  
  /**
   update
   Fired by the DataStateItems when an update occurs for the posts
   - parameter posts: [FlickPost]
   */
  func updateFlick(posts:[FlickPost]) {
    loading = false
//    if let view = self.vc as? FlickPostView {
//      if (self.page > 1) {
//        view.reloadCollection()
//      } else {
//        view.reload()
//      }
//    }
  }
  
}
