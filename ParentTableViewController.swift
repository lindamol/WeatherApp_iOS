//
//  ParentTableViewController.swift
//  MYProjectios
//
//  Created by user203935 on 10/25/21.
//

import UIKit
import CoreData
import Foundation
class ParentTableViewController: UITableViewController, UISearchBarDelegate
    {
    //weak var tableRef : UITableViewCell?
    lazy var myFetchResult : NSFetchedResultsController <City> = {
        let fetch:NSFetchRequest<City> = City.fetchRequest()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        fetch.sortDescriptors = [NSSortDescriptor(key: "cityname", ascending: true)]
        let ftcResult = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        ftcResult.delegate = self
        return ftcResult
    }()
    
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
//    func getcityName(selCity : String)
//    {
//        selectedCity = selCity
//        print("This is my selectedCity \(selectedCity)")
//    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchBar.delegate = self
        try? myFetchResult.performFetch()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func unwindSave(segue: UIStoryboardSegue) {
        guard segue.identifier == "save" else {return }
        let sourceViewController = segue.source as! EditViewController
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        if let _ = sourceViewController.thisCity {
//           try? context.save()
//        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return myFetchResult.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myFetchResult.sections?[section].numberOfObjects ?? 0// weather data
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        //cell.textLabel?.text = myarray[indexPath.row]
        let myCityName = myFetchResult.object(at: indexPath)
        //print("City from CoreData: \(String(describing: myCityName.cityname))")
        //cell.textLabel?.text = myCityName.cityname
        cell.configuremycell(myCityName: myCityName)
        
        // Configure the cell...
        return cell
    }
   
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let obj = myFetchResult.object(at: indexPath)
//            context.delete(obj)
//                        context.delete(obj)
//                        CoreDataStack.shared.saveContext()
//            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


