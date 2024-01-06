//
//  +UIImageView.swift
//  HotelTestTask
//
//  Created by Семен Гайдамакин on 15.12.2023.
//

import Foundation
import UIKit

class WebImageView : UIImageView {
    
    private var currentUrlString: String?
    
    func set(imageURL: String?) {
        currentUrlString = imageURL
        
        guard let imageURL = imageURL, let url = URL(string: imageURL) else {
            self.image = nil
            return
        }
        
        // проверяем есть ли картинка в кэше
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            print("from cache")
            return // Если каритнка уже есть в кэше, то загрузка дальше не идет
        }
        print("from internet")
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data:  data) // выполняем это в handle loaded Image проверяя существует ли уже реальная ссылка
                    self?.handleLoadedImage(data: data, response: response) // сохраням картинку в кэш
                } else {
                    self?.image = UIImage(named: "заглушка")
                }
            }
        }
        dataTask.resume()
    }
    
    // Сохранение картинки в кэш
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL)) // передаем в storeCached который хранит в себе кэшированый ответ для указанного запроса
        
        if responseURL.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }
}


extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
