//
//  DataProvider.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import Foundation
import Combine

protocol DataProvider {
  
  var imagePublisher: AnyPublisher<ImageItem, Never> { get }
  
  func fetchImages() async throws
  
}
