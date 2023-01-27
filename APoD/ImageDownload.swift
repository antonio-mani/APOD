//
//  ImageDownload.swift
//  APoD
//
//  Created by Antonio Maniscalco on 4/13/22.
//

import SwiftUI
import Combine

class ImageDownload: ObservableObject {
    @Published var hasLoaded = false
    @Published var imageDown: UIImage? = nil
}

extension ImageDownload {
    func load(_ urlStr: String) {
        guard let url = URL(string: urlStr) else {
            fatalError("Can't grab image")
        }
        Const.session
            .dataTask(with: url, completionHandler: imageHandler)
            .resume()
    }
    
    func imageHandler(data: Data?, res: URLResponse?, error: Error?) {
        guard let data = data, error == nil else {
            fatalError("Cant get image data")
        }
        DispatchQueue.main.async {
            self.imageDown = UIImage(data: data)
        }
    }
}
