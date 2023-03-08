//
//  NetworkService.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import Foundation
import Alamofire
import Combine
import AlamofireImage

final class NetworkService {
  
  var imageSubject = PassthroughSubject<ImageItem, Never>()
  
  // todo: put it away
  private let apiKey = "https://picsum.photos/v2/list"
  
  func fetchData() async throws -> Data {
    try await Task.sleep(nanoseconds: 1_000_000_000)

    return try await withCheckedThrowingContinuation { continuation in
        AF.request(apiKey)
        .responseData { response in
            switch(response.result) {
            case let .success(data):
                continuation.resume(returning: data)
            case .failure:
              // todo: handle errors
              print("ERROR ON FETCHING DATA")
              
              break
            }
        }
    }
  }
  
  func fetchImage(_ url: String, authorName: String) {
    AF.request(url).responseImage { [weak self] response in
      switch (response.result) {
      case let .success(image):
        self?.imageSubject.send(
          .init(
            isFavourite: false,
            authorName: authorName,
            url: url,
            image: image
          )
        )
        
      case .failure(_):
        // todo: handle errors
        print("ERROR ON FETCHING DATA")
        
        break
      }
    }
  }
  
}


