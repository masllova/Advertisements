//
//  DetailViewController.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 28.08.2023.
//

import UIKit
import MessageUI
import MapKit

class DetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    var advertisement: Advertisement?
    private let viewItems = DetailViewItemsCollection()

    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        navigationSetUp()
        imageSetUp()
        generalPanelSetUp()
        mapSetUp()
        infPanelSetUp()
        buyButtonSetUp()
    }
    func navigationSetUp() {
        navigationController?.navigationBar.tintColor = .label
        
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItems = [shareButton, favoriteButton]
    }
    func imageSetUp() {
        loadImage()
        view.addSubview(viewItems.image)
        NSLayoutConstraint.activate([
            viewItems.image.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            viewItems.image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            viewItems.image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            viewItems.image.heightAnchor.constraint(equalToConstant: 270)
        ])
    }
    func generalPanelSetUp() {
        viewItems.priceLabel.text = advertisement?.price
        viewItems.titleLabel.text = advertisement?.title
        viewItems.descriptionLabel.text = advertisement?.description
        viewItems.callButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
        viewItems.emailButton.addTarget(self, action: #selector(sendEmailButtonTapped), for: .touchUpInside)
        view.addSubview(viewItems.priceLabel)
        view.addSubview(viewItems.emailButton)
        view.addSubview(viewItems.callButton)
        view.addSubview(viewItems.titleLabel)
        view.addSubview(viewItems.divider)
        view.addSubview(viewItems.descriptionLabel)
        NSLayoutConstraint.activate([
            viewItems.priceLabel.topAnchor.constraint(equalTo: viewItems.image.bottomAnchor, constant: 10),
            viewItems.priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            viewItems.emailButton.topAnchor.constraint(equalTo: viewItems.image.bottomAnchor, constant: 10),
            viewItems.emailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            viewItems.callButton.topAnchor.constraint(equalTo: viewItems.image.bottomAnchor, constant: 10),
            viewItems.callButton.trailingAnchor.constraint(equalTo: viewItems.emailButton.leadingAnchor, constant: -30),
            viewItems.titleLabel.topAnchor.constraint(equalTo: viewItems.priceLabel.bottomAnchor, constant: 15),
            viewItems.titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            viewItems.descriptionLabel.topAnchor.constraint(equalTo: viewItems.titleLabel.bottomAnchor, constant: 5),
            viewItems.descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            viewItems.divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            viewItems.divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),
            viewItems.divider.topAnchor.constraint(equalTo: viewItems.descriptionLabel.bottomAnchor, constant: 7)
        ])
    }
    func mapSetUp() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 16
        if let city = advertisement?.location{
            showLocationOnMap(cityName: city)
        }
        view.addSubview(viewItems.backView)
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            viewItems.backView.topAnchor.constraint(equalTo: viewItems.descriptionLabel.bottomAnchor, constant: 20),
            viewItems.backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            viewItems.backView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            viewItems.backView.heightAnchor.constraint(equalToConstant: 170),
            mapView.topAnchor.constraint(equalTo: viewItems.backView.topAnchor, constant: 3),
            mapView.leadingAnchor.constraint(equalTo: viewItems.backView.leadingAnchor, constant: 3),
            mapView.trailingAnchor.constraint(equalTo: viewItems.backView.trailingAnchor, constant: -3),
            mapView.bottomAnchor.constraint(equalTo: viewItems.backView.bottomAnchor, constant: -3)
                ])
    }
    func infPanelSetUp() {
        viewItems.addressLabel.text = advertisement?.address
        viewItems.dateLabel.text = advertisement?.createdDate
        view.addSubview(viewItems.addressLabel)
        view.addSubview(viewItems.dateLabel)
        NSLayoutConstraint.activate([
            viewItems.addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 5),
            viewItems.addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewItems.dateLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 5),
            viewItems.dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    func buyButtonSetUp() {
        view.addSubview(viewItems.buyButton)
        NSLayoutConstraint.activate([
            viewItems.buyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            viewItems.buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewItems.buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    @objc func favoriteButtonTapped() {
        
    }
    @objc func shareButtonTapped() {
        
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func callButtonTapped() {
        var tel = ""
        if let number = advertisement?.phoneNumber {
            let characters = CharacterSet.decimalDigits
            tel = String(number.unicodeScalars.filter{ characters.contains($0) })
        }
        if let url = URL(string: "tel:\(tel)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    @objc func sendEmailButtonTapped() {
        if let recipient = advertisement?.email {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            mailComposeViewController.setToRecipients([recipient])
            present(mailComposeViewController, animated: true, completion: nil)
        } else {
            print("Устройство не может отправлять почту.")
        }
    }
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
    func showLocationOnMap(cityName: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            if let error = error {
                print("Ошибка геокодирования: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                if let location = placemark.location {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                    self.mapView.setRegion(region, animated: true)
                }
            }
        }
    }
    private func loadImage() {
        guard let imageURL = advertisement?.imageURL else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.viewItems.image.image = image
                    self.viewItems.image.layer.cornerRadius = 8
                    self.viewItems.image.clipsToBounds = true
                }
            }
        }
    }
}
