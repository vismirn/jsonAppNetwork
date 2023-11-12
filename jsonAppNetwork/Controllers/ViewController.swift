//
//  ViewController.swift
//  jsonAppNetwork
//
//  Created by Viktor Smirnov on 10.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        getUrlPhoto()
        getPhoto()
    
        
        
    }
    private func getUrlPhoto() {
        URLSession.shared.dataTask(with: DogRandom.init().urlRandom) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let jsonDecoder = JSONDecoder()
            
            do {
                let urlPhoto = try jsonDecoder.decode(GetUrlPhoto.self, from: data)
                let newMessage = String(urlPhoto.message)
                print(newMessage)
            } catch let error {
                print(error.localizedDescription)
            }
//            print(GetUrlPhoto.init(message: newMessage, status: String))
//            guard let urlPhoto = try jsonDecoder.decode(GetUrlPhoto.self, from: data) else {
//                return
//            }
//            urlPhoto.message
        }.resume()
    }
    
    
    private func getPhoto() {
        URLSession.shared.dataTask(with: DogRandom.init().urlDogRandom) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
            }
        }.resume()
    }
}
