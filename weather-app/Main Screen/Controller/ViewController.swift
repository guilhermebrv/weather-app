//
//  ViewController.swift
//  weather-app
//
//  Created by Guilherme Viana on 29/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var screen: View?
    private var viewModel: ViewModel = ViewModel()
    
    override func loadView() {
        screen = View()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
    }
    
    private func signProtocols() {
        screen?.delegate(delegate: self)
        screen?.searchTextField.delegate = self
        viewModel.delegate(delegate: self)
    }
}

extension ViewController: ViewProtocol, ViewModelProtocol, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.tappedSearchButton()
        textField.text = ""
    }

    func tappedSearchButton() {
        if let city = screen?.searchTextField.text {
            viewModel.fetchDataFromService(cityname: city)
        }
        screen?.searchTextField.text = ""
    }
    
    func successFetchingData() {
        updateCity()
    }
    
    func updateCity() {
        DispatchQueue.main.async { [self] in
            let weather = viewModel.getWeather()
            self.screen?.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.screen?.cityLabel.text = weather.cityName
            self.screen?.temperatureLabel.text = weather.temperatureFormatted
        }
    }
    
    func errorFetchingData() {
        print("error fetching data")
    }
    
}

