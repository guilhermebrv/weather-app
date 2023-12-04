//
//  View.swift
//  weather-app
//
//  Created by Guilherme Viana on 29/11/2023.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func tappedSearchButton()
    func tappedLocationButton()
}

class View: UIView {
    
    private weak var delegate: ViewProtocol?
    public func delegate(delegate: ViewProtocol) {
        self.delegate = delegate
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var bgImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "background")
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedLocationButton), for: .touchUpInside)
        let imageView = UIImageView(image: UIImage(systemName: "location.north.circle.fill")?.withRenderingMode(.alwaysTemplate))
        button.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        return button
    }()
    
    @objc func tappedLocationButton() {
        delegate?.tappedLocationButton()
    }
    
    lazy var searchTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.tintColor = .label
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 17.5
        textfield.backgroundColor = .lightGray.withAlphaComponent(0.2)
        textfield.textAlignment = .right
        textfield.placeholder = "Search for city"
        textfield.autocapitalizationType = .words
        textfield.returnKeyType = .search
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textfield.rightView = rightPaddingView
        textfield.rightViewMode = .always
        return textfield
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate))
        button.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFit
        imageView.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        return button
    }()
    
    @objc func tappedSearchButton() {
        delegate?.tappedSearchButton()
    }
    
    lazy var conditionImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(systemName: "sun.max")?.withRenderingMode(.alwaysTemplate)
        imageview.tintColor = .label
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "21"
        label.textColor = .label
        label.font = .systemFont(ofSize: 50, weight: .bold)
        return label
    }()
    
    lazy var celsiusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ºC"
        label.textColor = .label
        label.font = .systemFont(ofSize: 50, weight: .regular)
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "London"
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(bgView)
        bgView.addSubview(bgImageView)
        bgView.addSubview(locationButton)
        bgView.addSubview(searchTextField)
        bgView.addSubview(searchButton)
        bgView.addSubview(conditionImageView)
        bgView.addSubview(temperatureLabel)
        bgView.addSubview(celsiusLabel)
        bgView.addSubview(cityLabel)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bgImageView.topAnchor.constraint(equalTo: topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            locationButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            locationButton.trailingAnchor.constraint(equalTo: searchTextField.leadingAnchor, constant: -5),
            
            searchTextField.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            searchTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchTextField.widthAnchor.constraint(equalTo: bgView.widthAnchor, multiplier: 0.7),
            searchTextField.heightAnchor.constraint(equalToConstant: 35),
            
            searchButton.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 5),
            
            conditionImageView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            conditionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            conditionImageView.heightAnchor.constraint(equalToConstant: 80),
            conditionImageView.widthAnchor.constraint(equalToConstant: 80),
            
            celsiusLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: 10),
            celsiusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: celsiusLabel.leadingAnchor, constant: -7),
            temperatureLabel.centerYAnchor.constraint(equalTo: celsiusLabel.centerYAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: celsiusLabel.bottomAnchor, constant: 5),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
