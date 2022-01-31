//
//  TableViewCell.swift
//  MYProjectios
//
//  Created by user203935 on 10/25/21.
//

import UIKit


import UIKit
import CoreData
class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        func hello()
        {
            print("Just Hello")
        }
        
    }
    
    public func configuremycell(myCityName: City){
      textLabel?.text = myCityName.cityname
      detailTextLabel?.text = "temperature"
      imageView?.image = UIImage(systemName: "photo")
        print("This is my cityname: \(String(describing: myCityName.cityname))")
        if let passedCityName = myCityName.cityname
           {  let weatherurl = "http://api.openweathermap.org/data/2.5/weather?"
             let query = ["q":passedCityName,"APPID":apiKey]
            print("My URL: \(weatherurl) and my query : \(query)")
        //http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=ee5826503014a1311afdf783a4c42efb"
            Service.shared.getJsonData(myURL: weatherurl, query: query) { (Result) in
                switch Result{
                    case .failure(let error):print(error)
                        DispatchQueue.main.async { // ask to keep on running back to server
                            self.detailTextLabel?.text = "NA"
                            //self.imageView?.image = UIImage(systemName: "photo")
                        }//dispach
                    case .success(let data):
                        if let data = try? JSONDecoder().decode(WeatherResult.self, from: data){
                            DispatchQueue.main.async {
                            self.detailTextLabel?.text = "\(data.main.temp)"
                        }
                        if let imageIcon = data.weather?[0].icon{
                           
                            /// Start from here ,I converted url string to url Type
                            var iconURL: URL! //iconURL is of the type url, We were passing of the type String
                            iconURL = URL(string: "http://openweathermap.org/img/wn/\(imageIcon)@2x.png")
                            print("This is my image url: \(String(describing: iconURL))")
                            //Removed all the switch statements
                            /////////////////////Get image////////////////
                            ///getImageData is the new function I created in the ServerService
                            Service.shared.getImageData(from: iconURL) { data, response, error in
                                guard let data = data, error == nil else { return}
                                DispatchQueue.main.async() { [weak self] in
                                    self?.imageView?.image = UIImage(data: data)
                                }
                            }
                           ////////////////////////////////////////
                        }
                        
                    }
                }//switch closure
            }//result closure
        }//if let
    }//func
    
//       override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
}
