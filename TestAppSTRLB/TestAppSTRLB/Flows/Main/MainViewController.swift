//
//  ViewController.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import UIKit
import Combine

final class MainViewController: NiblessViewController {
  
  private var subscriptions = Set<AnyCancellable>()
  
  private let tableView = UITableView(frame: .zero, style: .plain)
  private let viewModel: MainViewModel
  
  init(viewModel: MainViewModel) {
    self.viewModel = viewModel
    
    super.init()
    
    setupBindings()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  private func setupView() {
    // todo: move string value to the localizable file
    title = "Select favourite images"

    // todo: add loader during fetching data
    setupTableView()
  }
  
  private func setupTableView() {
    tableView.accessibilityIdentifier = "tableView"
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 100.0
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  private func setupBindings() {
    viewModel.reloadData
      .sink { [weak self] _ in
        self?.tableView.reloadData()
      }.store(in: &subscriptions)
  }
  
  @objc
  private func showFavouriteImages() {
    viewModel.showFavouriteImages()
  }
  
}

extension MainViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.showImageDetailAt(indexPath: indexPath)
  }
  
}

extension MainViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.cellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    cell.imageView?.sizeThatFits(.init(width: 100.0, height: 100.0))
    cell.imageView?.image = viewModel.cellViewModels[indexPath.row].image
    
    if viewModel.cellViewModels[indexPath.row].isFavourite {
      cell.accessoryView = UIImageView(image: .init(systemName: "star.fill"))
    }
    
    return cell
  }
  
}
