//
//  ImageItemDetailsViewController.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import UIKit

final class ImageItemDetailsViewController: NiblessViewController {
  
  let favouriteButton = UIButton()
  private let viewModel: ImageItemDetailsViewModel
  
  init(viewModel: ImageItemDetailsViewModel) {
    self.viewModel = viewModel
    
    super.init()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  private func setupView() {
    // todo: move string value to the localizable file
    title = "Image detail"
    view.backgroundColor = .white
    
    let imageView = UIImageView(image: viewModel.item.image)
    imageView.accessibilityIdentifier = "imageView"
    view.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    let authorNameLabel = UILabel()
    authorNameLabel.text = viewModel.item.authorName
    authorNameLabel.accessibilityIdentifier = "authorNameLabel"
    view.addSubview(authorNameLabel)
    authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
    authorNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20.0).isActive = true
    authorNameLabel.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
    authorNameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 50).isActive = true
    
    favouriteButton.setImage(
      viewModel.item.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"),
      for: .normal
    )
    favouriteButton.accessibilityIdentifier = "favouriteButton"
    view.addSubview(favouriteButton)
    favouriteButton.translatesAutoresizingMaskIntoConstraints = false
    favouriteButton.topAnchor.constraint(equalTo: authorNameLabel.topAnchor).isActive = true
    favouriteButton.leadingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor, constant: 30).isActive = true
    favouriteButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
  }
  
  @objc
  private func buttonTapped() {
    viewModel.buttonTapped()
    favouriteButton.setImage(
      viewModel.item.isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"),
      for: .normal
    )
  }
  
}
