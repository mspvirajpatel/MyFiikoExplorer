//
//  Contest.swift
//  FiikoExplorer
//
//  Created by Viraj on 03/04/17.
//  Copyright © 2017 Viraj. All rights reserved.
//


import UIKit

enum StoryboardName : String {
  case Main = "Main"
  case Onboarding = "Onboarding"
}

struct Constants {
  static let defaultFlickSearchTerm = "dogs"
  static let flickTitle = "Flick"
  static let flickPostsURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e2d8c80fd64429f9374a81aa39f9619e&tags=%@&page=%@&per_page=%@&format=json&nojsoncallback=1"
  static let flickHorizontalTitle = "Animals"
    
  static let flickPostsPerPage = 25
}

enum FlickrPostType : String {
  case Dogs = "Dogs"
  case Cats = "Cats"
  case Monkeys = "Monkeys"
  case Elephants = "Elephants"
  case Lions = "Lions"
  case Tigers = "Tigers"
  case Bears = "Bears"
  case OhMy = "Oh"
}
