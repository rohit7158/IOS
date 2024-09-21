//
//  ForgotPasswordViewController.swift
//  MultiPageApp
//
//  Created by Rohit Chauhan on 2024-06-22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let redView = UIView()
        redView.backgroundColor = .red
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)

        // Example: Adding constraints programmatically
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            redView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
