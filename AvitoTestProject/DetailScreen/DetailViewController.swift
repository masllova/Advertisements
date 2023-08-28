//
//  DetailViewController.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 28.08.2023.
//

import UIKit

class DetailViewController: UIViewController {
    var advertisement: Advertisement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .background
        navigationController?.navigationBar.tintColor = .label
    }
    
}
