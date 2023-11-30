//
//  ViewController.swift
//  weather-app
//
//  Created by Guilherme Viana on 29/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var screen: View?
    
    override func loadView() {
        screen = View()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
        dismissKeyBoard()
    }
    
    private func signProtocols() {
        screen?.delegate(delegate: self)
        screen?.searchTextField.delegate = self
    }
}

extension ViewController: ViewProtocol, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.tappedSearchButton()
        return true
    }
    
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func tappedSearchButton() {
        print("merda")
        print(screen?.searchTextField.text ?? "")
    }
    
}

