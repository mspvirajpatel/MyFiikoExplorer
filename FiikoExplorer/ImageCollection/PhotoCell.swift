//
//  PhotoCell.swift
//  FiikoExplorer
//
//  Created by Viraj on 03/04/17.
//  Copyright © 2017 Viraj. All rights reserved.
//

import UIKit
import NVActivityIndicatorView



class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    override func prepareForReuse() {
        photoImageView.image = nil
        super.prepareForReuse()
    }
    
    func downloadPhotoWithTags(photoItem: PhotoItem) {
        setIndicator()
        photoItem.loadImage(size: "n") { completion in
            if completion != nil {
                self.photoImageView.image = completion
            }
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    fileprivate func setIndicator() {
        activityIndicatorView.color = .gray
        activityIndicatorView.type = .ballClipRotate
        activityIndicatorView.startAnimating()
    }
}
