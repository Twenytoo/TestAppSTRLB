//
//  ImageItemDetailsViewModel.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import Foundation

final class ImageItemDetailsViewModel {
  
  var item: ImageItem {
    model.item
  }
  
  private let model: ImageItemDetailsModel
  
  init(model: ImageItemDetailsModel) {
    self.model = model
  }
  
  func buttonTapped() {
    model.item.isFavourite.toggle()
  }
  
}
