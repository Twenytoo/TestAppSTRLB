//
//  MainModel.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import UIKit
import Combine

protocol MainModelNavigationHandler {
  
  func mainModelDidShowFavouritesImages(_ model: MainModel)
  func mainModel(_ model: MainModel, didShowDetailsForSelected item: ImageItem)
  
}

final class MainModel {
  
  var imagesPublisher: AnyPublisher<[ImageItem], Never> {
    dataProvider.imagePublisher
      .scan([]) { acculatoredImages, newImage -> [ImageItem] in
        var images: [ImageItem] = acculatoredImages
        images.append(newImage)
        
        return images
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  private let dataProvider: DataProvider
  private let navigationHandler: MainModelNavigationHandler
  
  init(
    dataProvider: DataProvider,
    navigationHandler: MainModelNavigationHandler
  ) {
    self.dataProvider = dataProvider
    self.navigationHandler = navigationHandler
    
    fetchImages()
  }
  
  func showFavouriteImages() {
    navigationHandler.mainModelDidShowFavouritesImages(self)
  }
  
  func showDetailFor(item: ImageItem) {
    navigationHandler.mainModel(self, didShowDetailsForSelected: item)
  }
  
  private func fetchImages() {
    Task {
      do {
        // todo: add loader
        try await dataProvider.fetchImages()
      } catch {
        // todo: handle errors
      }
    }
    
  }
  
}
