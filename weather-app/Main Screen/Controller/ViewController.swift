//
//  ViewController.swift
//  weather-app
//
//  Created by Guilherme Viana on 29/11/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private var screen: View?
    private var viewModel: ViewModel = ViewModel()
    private var locationManager: CLLocationManager = CLLocationManager()
    
    override func loadView() {
        screen = View()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
        self.tappedLocationButton()
    }
    
    private func signProtocols() {
        screen?.delegate(delegate: self)
        screen?.searchTextField.delegate = self
        locationManager.delegate = self
        viewModel.delegate(delegate: self)
    }
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.tappedSearchButton()
        textField.text = ""
    }
}

// MARK: ViewModelProtocol
extension ViewController: ViewModelProtocol {
    func tappedSearchButton() {
        if let city = screen?.searchTextField.text {
            viewModel.fetchDataFromServiceByCityName(cityname: city)
        }
        screen?.searchTextField.text = ""
    }
    
    func tappedLocationButton() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            viewModel.fetchDataFromServiceByCoordinates(lat: lat, lon: lon)
            print(lat, lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: ViewProtocol
extension ViewController: ViewProtocol {
    func errorFetchingData(error: String) {
        print(error)
    }
    
    func successFetchingData() {
        DispatchQueue.main.async { [self] in
            screen?.conditionImageView.isHidden = false
            screen?.temperatureLabel.isHidden = false
            screen?.celsiusLabel.isHidden = false
            screen?.cityLabel.isHidden = false
            let weather = viewModel.getWeather()
            self.screen?.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.screen?.cityLabel.text = weather.cityName
            self.screen?.temperatureLabel.text = weather.temperatureFormatted
        }
    }
}

