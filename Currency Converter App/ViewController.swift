//
//  ViewController.swift
//  Currency Converter App
//
//  Created by Vũ Linh on 28/04/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func didTapChangeView(_ sender: UIButton) {
        let vc = DetailsViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.title = "Currency Converter"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
