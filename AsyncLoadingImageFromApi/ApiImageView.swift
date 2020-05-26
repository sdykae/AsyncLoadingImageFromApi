//
//  ApiImageView.swift
//  AsyncLoadingImageFromApi
//
//  Created by rkedlor on 5/26/20.
//  Copyright © 2020 rkedlor. All rights reserved.
//

import SwiftUI

struct ApiImageView: View {
  @ObservedObject var apiImage = ApiImage()
  var body: some View {
    Group {
      if apiImage.dataHasLoaded {
        Image(uiImage: apiImage.image!)
      } else {
        Text("Loading Data")
      }
    }.onAppear{
      self.apiImage.loadImageFromApi(urlString: "https://api.nasa.gov/planetary/apod?api_key=LVUHuiNxQ6ceTVQJTwefI03LFn4KFy3zOX0NDLsY")
    }
  }
}

struct ApiImageView_Previews: PreviewProvider {
    static var previews: some View {
        ApiImageView()
    }
}
