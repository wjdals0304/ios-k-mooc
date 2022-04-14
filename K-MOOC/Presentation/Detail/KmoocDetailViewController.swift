//
//  KmoocDetailViewController.swift
//  K-MOOC
//
//  Created by 김정민 on 2022/04/14.
//

import UIKit

final class KmoocDetailViewController: UIViewController {
    
    private let detailView = KmoocDetailView()

    override func loadView() {
        super.loadView()
        self.view = detailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupConstraint()
    }
    
    func setup() {
        
    }
    
    func setupConstraint() {
        
    }

}
