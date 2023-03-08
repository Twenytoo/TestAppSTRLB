//
//  NiblessViewControler.swift
//  TestAppSTRLB
//
//  Created by Artem Lushchan on 08.03.2023.
//

import UIKit

open class NiblessViewController: UIViewController {
    
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    fatalError("Init is not implemented")
  }

}
