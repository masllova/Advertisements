//
//  MainViewController.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 27.08.2023.
//

import UIKit

class MainViewController: UIViewController {
    private let presenter: MainViewPresenter!
    
    init(with presenter: MainViewPresenter!) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

