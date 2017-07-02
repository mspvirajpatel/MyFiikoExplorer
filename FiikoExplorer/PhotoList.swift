//
//  PhotoList.swift
//  FiikoExplorer
//
//  Created by Viraj on 03/04/17.
//  Copyright © 2017 Viraj. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotoList {
    
    func addPhotoToList(jsonPhotoList: JSON) -> [PhotoItem] {
        var photos = [PhotoItem]()
        for item in jsonPhotoList.arrayValue {
            let photoID: String = item["id"].stringValue
            let farm: Int = item["farm"].intValue
            let server: String = item["server"].stringValue
            let secret: String = item["secret"].stringValue
            let title: String = item["title"].stringValue
            photos.append(PhotoItem(photoID: photoID, farm: farm, server: server, secret: secret, title: title))
        }
        return photos
    }
}
