//
//  ExtensionUIImageView.swift
//  FiikoExplorer
//
//  Created by Viraj on 03/04/17.
//  Copyright © 2017 Viraj. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
  
  /**
   greyFade
   Provides a fade to grey gradient effect.
   Used on the Artist View and Home View
   - parameter isHome: Bool : False - true for the home page
   */
  func greyFade(_ isHome:Bool=false) {
    let gradiant : CAGradientLayer = CAGradientLayer()
    gradiant.frame = self.bounds
    if isHome {
      gradiant.startPoint = CGPoint(x: 0, y: 0.1)
      gradiant.endPoint = CGPoint(x: 0, y: 1.0)
    }
    gradiant.colors = [UIColor.gray.cgColor, UIColor.clear.cgColor]
    self.layer.mask = gradiant
  }
  
  /**
   blur
   Create a blur effect for the imageview
   Used for the Artist View Background image
   */
  func blur() {
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light)) as UIVisualEffectView
    visualEffectView.frame = self.bounds
    self.addSubview(visualEffectView)
  }
  
  /**
   roundify
   Make the edges of a UIImageView rounded into a circle.
   Used for the Artist View, Player View, potentially elsewhere.
   */
  func roundify() {
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderWidth=2.0;
    self.layer.borderColor = UIColor.white.cgColor
    self.clipsToBounds = true;
  }
  
  func borderize() {
    self.layer.borderWidth=2.0;
    self.layer.borderColor = UIColor.white.cgColor
    self.clipsToBounds = true;
  }
  /**
   fadeIn
   Contains the logic around which images to load and how to handle the URL Strings
   Handles the cleanining of URLs for loading in the imageView
   Can handle callback. W/O callback, will change its own alpha vals
   - parameter url:           String
   - parameter useEmptyAlbum: Bool : False - which default image to load
   - parameter handler:       (UIImage)->() : Nil, Optional Calllback
   */
  func fadeIn(_ url:String, useEmptyAlbum:Bool=false, handler: ((UIImage)->())? = nil) {
    
    if !(url.contains("http://") || url.contains("https://")) {
      // Load Local Image
      let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
      let path = documentsPath + url
      let image = UIImage(contentsOfFile: path)
      if image != nil {
        self.image = image
        self.handleFadeInImageHandler(handler)
      } else {
        var toks = url.characters.split{$0 == "."}.map(String.init)
        self.image = UIImage(contentsOfFile: Bundle.main.path(forResource: toks[0], ofType:toks[1] )!)
      }
    } else {
      // Load Remote Image
      let urlClean = cleanImageURL(url)
      self.sd_setImage(with: urlClean, completed: { Void in
        self.handleFadeInImageHandler(handler)
      })
    }
  }
  
  /**
   handleFadeInImageHandler
   This is a private convenience function that allows for the execution of a callback
   DO not simply change the alpha of the UIImageView if there IS a handler
   IF there is a handler, defer the behavior to the handler and NOT the UIImageView.
   - parameter handler: (UIImage)->()? = nil (optional handler)
   */
  fileprivate func handleFadeInImageHandler(_ handler:((UIImage)->())? = nil) {
    if self.alpha != 1.0 && handler == nil {
      UIView.animate(withDuration: 0.2, animations: { self.alpha = 1.0 })
    }
    if handler != nil && self.image != nil {
      handler!(self.image!)
    }
  }
  
  /**
   cleanImageURL
   Clean the incoming URL of issues with encoding. There can be a number of things
   that need to be done to the string because its encoding cannot be trusted and
   seems to change based on the source.
   - parameter url: String
   - returns: NSURL
   */
  fileprivate func cleanImageURL(_ url:String) -> URL {
    
    if url.contains(" ") {
      let cleanURL = url.replacingOccurrences(of: " ", with: "%20")
      return URL(string: cleanURL)!
    }
    return URL(string: url)!
    
  }
  
}
