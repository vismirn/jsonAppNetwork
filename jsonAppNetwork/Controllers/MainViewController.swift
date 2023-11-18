//
//  ViewController.swift
//  jsonAppNetwork
//
//  Created by Viktor Smirnov on 10.11.2023.
//

import UIKit
import Alamofire

final class MainViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        getUrlPhoto { urlImage in
            self.getPhoto(url: urlImage)
        }
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
    
    private func getInfoFromAlomofire(url: String, completion: @escaping(String) -> Void) {
        AF.request("https://dog.ceo/api/breeds/image/random")
            .validate()
            .responseJSON { data in
                switch data.result {
                case .success(let value):
                    let data = getPhoto(url: url)
                    completion(.success(url))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
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
