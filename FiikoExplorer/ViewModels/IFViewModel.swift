//
//  IFViewModel.swift
//  FiikoExplorer
//
//  Created by Viraj on 03/04/17.
//  Copyright © 2017 Viraj. All rights reserved.
//

import UIKit

class IFViewModel : NSObject {
  weak var vc : UIViewController? = nil
  
  convenience override init() {
    self.init(viewController : nil)
  }
  
  init(viewController : UIViewController?) {
    self.vc = viewController
    super.init()
  }

  // Called on Accessory Views
  func dismiss() {
  }
}
