//
//  ImageData.swift
//  ImageDownloader
//
//  Created by Ravi Gelani on 2023-11-14.
//

import Foundation

class ImageData {
    
    var imageName : String = ""
    var imageURL : Data? = nil
    
    init(imageName: String) {
        self.imageName = imageName
    }
}
