//
//  ViewController.swift
//  jsonAppNetwork
//
//  Created by Viktor Smirnov on 10.11.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        getUrlPhoto { urlImage in
            self.getPhoto(url: urlImage)
        }
//        getPhoto()
    
        
        
    }
    private func getUrlPhoto(completion: @escaping(String) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://dog.ceo/api/breeds/image/random")!) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let jsonDecoder = JSONDecoder()
            
            do {
                let urlPhoto = try jsonDecoder.decode(GetUrlPhoto.self, from: data)
                completion(urlPhoto.message)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    
    private func getPhoto(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
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
