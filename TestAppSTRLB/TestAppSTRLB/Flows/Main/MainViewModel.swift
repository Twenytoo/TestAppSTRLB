//
//  MainViewModel.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import UIKit
import Combine

final class MainViewModel {
  
  var cellViewModels: [ImageItem] = [] {
    didSet {
      reloadDataSubject.send()
    }
  }
  
  var reloadData: AnyPublisher<Void, Never> {
    reloadDataSubject
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  private let reloadDataSubject = PassthroughSubject<Void, Never>()
  
  private var subscriptions = Set<AnyCancellable>()
  private let model: MainModel
  
  init(model: MainModel) {
    self.model = model
    
    setupBindings()
  }
  
  func showFavouriteImages() {
    model.showFavouriteImages()
  }
  
  func showImageDetailAt(indexPath: IndexPath) {
    let item = cellViewModels[indexPath.row]
    model.showDetailFor(item: item)
  }
  
  private func setupBindings() {
    model.imagesPublisher
      .sink { [weak self] in
        self?.cellViewModels = $0
      }.store(in: &subscriptions)
  }

}
