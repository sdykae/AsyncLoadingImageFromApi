//
//  ApiImage.swift
//  AsyncLoadingImageFromApi
//
//  Created by rkedlor on 5/26/20.
//  Copyright © 2020 rkedlor. All rights reserved.
//

import SwiftUI

class ApiImage: ObservableObject {
  @Published var dataHasLoaded = false
  @Published var image: UIImage? = nil
}
extension ApiImage {
  func loadImageFromApi(urlString:String){
    guard let url = URL(string: urlString) else {return}
    var request = URLRequest(url:url)
    request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request, completionHandler: parseJsonObject)
    task.resume()
  }
  func parseJsonObject(data: Data?, urlResponse: URLResponse?, error: Error?){
    guard error == nil else {
      print("\(error!)")
      return
    }
    guard let content = data else {
      print("No data")
      return
    }
    let json = try! JSONSerialization.jsonObject(with: content)
    let jsonmap = json as! [String: Any]
    let urlString = jsonmap["url"] as! String
    print("\(urlString)")
    guard let url = URL(string: urlString) else {return}
    var request = URLRequest(url:url)
    request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request, completionHandler: setImageFromData)
    task.resume()
  }
  func setImageFromData(data: Data?, urlResponse: URLResponse?, error: Error?) {
    guard error == nil else {
      print("\(error!)")
      return
    }
    guard let content = data else {
      print("No data")
      return
    }
    DispatchQueue.main.async{
      self.image = UIImage(data:content)
      self.dataHasLoaded = true
    }
  }
}
