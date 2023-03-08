//
//  NetworkServiceAdapter.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import Foundation
import Combine

final class NetworkServiceAdapter: DataProvider {
  
  var imagePublisher: AnyPublisher<ImageItem, Never> {
    service.imageSubject
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  private let service: NetworkService
  
  init(service: NetworkService) {
    self.service = service
  }
  
  func fetchImages() async throws {
    let data = try await service.fetchData()
    let result: [PicsumPhotoData] = try parseData(data: data)
    
    result.forEach { data in
      service.fetchImage(data.download_url, authorName: data.author)
    }
  }
  
  private func parseData<T: Decodable>(data: Data) throws -> T {
      guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
      else {
          throw NSError(
              domain: "NetworkAPIError",
              code: 3,
              userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
          )
      }
      return decodedData
  }
  
}
