//
//  Api.swift
//  APoD
//
//  Created by Antonio Maniscalco on 4/8/22.
//

import SwiftUI

class Api: ObservableObject {
    @Published var hasLoaded = false
    @Published var requestErr = false
    @Published var noImage = false
    @Published var image: UIImage? = nil
    @Published var title: String? = nil
    @Published var explanation: String? = nil
    @Published var copyright: String? = nil

}

extension Api {
    func loadImage(urlStr: String) {
        guard let url = URL(string: urlStr) else {
            DispatchQueue.main.async {
                self.requestErr = true
                self.hasLoaded = false
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: parseJson)
        task.resume()
    }
    
    func parseJson(data: Data?, urlResponse: URLResponse?, error: Error?) {
        guard error == nil else {
            DispatchQueue.main.async {
                self.requestErr = true
                self.hasLoaded = false
            }
            print("Error.localizedDescription")
            //fatalError()
            return
        }
        
        guard let content = data else {
            print("NO DATA")
            DispatchQueue.main.async {
                self.requestErr = true
                self.hasLoaded = false
            }
            //fatalError()
            return
        }
        
        let jsonObj = try! JSONSerialization.jsonObject(with: content)
        let jsonMap = jsonObj as! [String: Any]
        guard let urlStr = jsonMap["url"] as! String? else {
            DispatchQueue.main.async {
                self.requestErr = true
                self.hasLoaded = false
            }
            return
        }
        
        let title = jsonMap["title"] as! String?
        let explanation = jsonMap["explanation"] as! String
        let copyRight = jsonMap["copyright"] as! String?
    
        guard let url = URL(string: urlStr) else {
            return
            //fatalError()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: setImage)
        DispatchQueue.main.async {
            if title == nil {
                self.title = "N/A"
            }
            self.title = title
            self.explanation = explanation
            
            if copyRight == nil {
                self.copyright = ""
                print("No Copyright found")
            } else {
                self.copyright = "copyright: " + copyRight!
            }
        }
        task.resume()
    }
    
    func setImage(data: Data?, urlResponse: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error.localizedDescription")
            return
        }
        
        guard let content = data else {
            print("NO DATA")
            return
        }
        
        if image == nil {
            DispatchQueue.main.async {
                self.noImage = true
                self.image = nil
                self.hasLoaded = true
            }
            
        }
        DispatchQueue.main.async {
            self.image = UIImage(data: content)
            //self.title = data.title
            self.hasLoaded = true
        }
    }
}
