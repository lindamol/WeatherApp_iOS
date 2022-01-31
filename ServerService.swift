//
//  ServerService.swift
//  MYProjectios
//
//  Created by user203935 on 10/25/21.
//

import Foundation
import UIKit
class Service {
    static var shared = Service()
    private init(){}
    enum getError : Error{
        case wrongURL
    }
    //http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=ee5826503014a1311afdf783a4c42efb
        //API : api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
   //Reading weatherData from the server url
        func getJsonData(myURL: String, query  : [String: String]?, completion: @escaping (Result<Data,Error>)-> Void) {
        var urlComponent = URLComponents(string: myURL)!
        print("URL before going to fetch JSON:\(urlComponent)")
        if let query = query { urlComponent.queryItems = query.map({URLQueryItem(name: $0.key, value: $0.value)})
        urlComponent.queryItems = query.map({ URLQueryItem(name: $0.key, value: $0.value) })
            guard let url = urlComponent.url
            else{
                return completion(.failure(getError.wrongURL))
            }
      
let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
               return  completion(.failure(error))
            }
    else if let data = data{
               completion(.success(data))
          }
        }
            task.resume()
    }
       
    }
    // Added to New function getImageData, 
    func getImageData(from url: URL, completion: @escaping(Data?, URLResponse?, Error?)->()){
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    /*func getImage(imgUrl : URL, completion : @escaping (Result<UIImage,Error>)->Void)  {
        URLSession.shared.dataTask(with: imgUrl) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data , let image = UIImage(data: data){
                completion(.success(image))
            }
            
        }.resume()
    }*/
}
