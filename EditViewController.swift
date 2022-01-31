//
//  EditViewController.swift
//  MYProjectios
//
//  Created by user203935 on 10/25/21.
//

import UIKit

class EditViewController: UIViewController {
//    lazy var resultsTableController = //self.storyboard?.instantiateViewController(withIdentifier: "ContainerforSearchVIew") //as? ContainerforSearchVIew
   
    @IBOutlet weak var ContainerforSearchVIew: UIView!

    let searchController = UISearchController()
    //let vc = SearchCityTableViewController()
    weak var searchVcRef : SearchCityTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        //editStackView.isHidden = false
        configurSearchController()
        // Do any additional setup after loading the view.
    }
    @objc func getData() {
        // let searchText = searchconroller.searchBar.text ?? ""//Toronto
        //http://gd.geobytes.com/AutoCompleteCity?callback=&q=Toronto
        let searchText = searchController.searchBar.text ?? ""
         let query = [ "q" : searchText, "callback" : "" ]
       // print("I am going to get JSON")
        if searchText.count <= 2 {return} //Search text will go and fetch if I type atleast 2 letters
     Service.shared.getJsonData(myURL: "http://gd.geobytes.com/AutoCompleteCity?",query: query) { (result) in
                 switch result
               {
                          case .failure(let error):
                              print(error)
                          case .success(let data):
                //# decode your data
                    // print("What is thissss???\(String(data:data, encoding: .utf8)!)")
                  //  if let xdata = String(data: data, encoding: .utf32)?.data(using: .utf32),
                     if let result = try? JSONDecoder().decode([String].self, from: data){
                                  let cityNames = result.reduce(into: [String]()) {
                                      let spliter = $1.split(separator: ",")
                                      if(spliter.count == 3) {$0.append(String(spliter[0]))}
                              }
                         self.searchVcRef?.Citylist = cityNames
                         print("These are MYCITYNAMES : \(cityNames)")
                              }
                            
                          }
         
     }}
    
    @IBOutlet weak var editStackView: UIStackView!
//    var thisCity : City? = nil {
//        didSet{
//            editStackView.isHidden = false
//            }
//    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if let searchVC = segue.destination as? SearchCityTableViewController//searchVC is segue
        {
            self.searchVcRef = searchVC
        //print("Segue for SearchController is Active now")
        }
        // Pass the selected object to the new view controller.
    }


}
extension EditViewController : UISearchResultsUpdating {
    func configurSearchController() {
        print("I am inside configure step2")
        //ContainerforSearchVIew.isHidden = false
       navigationItem.searchController = searchController//I am navigation Item of searchController
       searchController.searchResultsUpdater = self
       searchController.obscuresBackgroundDuringPresentation = false
       searchController.automaticallyShowsSearchResultsController = true
       // editStackView.isHidden = true
               
    }
    func updateSearchResults(for searchController: UISearchController) {
        //wait 1 secound see if there is not more calls
       // print("I am updating search result and going to fetchdata  from server step4\(String(describing: searchController.searchBar.text))")
       NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getData), object: nil)
       perform(#selector(getData), with: nil, afterDelay: 0.3) // calling getData

    }
    
}
