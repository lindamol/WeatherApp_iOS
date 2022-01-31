//
//  SearchCityTableViewController.swift
//  MYProjectios
//
//  Created by user203935 on 10/25/21.
//

import UIKit
import CoreData

class SearchCityTableViewController: UITableViewController {
    weak var editVcRef : EditViewController?
   // weak var parentRef : ParentTableViewController?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var Citylist: [String] = []{
    didSet {
        //print("Cittylist Array updated")
        DispatchQueue.main.async { self.tableView.reloadData() }}}
    override func viewDidLoad() {
        super.viewDidLoad()
          //print("My FINAL LIST:\(Citylist)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editVcRef?.navigationItem.title = Citylist[indexPath.row]
        let city = City(context: self.context)
        city.cityname = Citylist[indexPath.row]
        // save data in coredata
        
        do{ try self.context.save()
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        catch{ print("Error in saving data")}
        
       // parentRef?.getcityName(selCity: editVcRef?.navigationItem.title ?? "")
        
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Citylist.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSearch", for: indexPath)
        cell.textLabel?.text = Citylist[indexPath.row]
        // Configure the cell...
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let seguetoedit = segue.destination as? EditViewController
        {
            self.editVcRef = seguetoedit
            //editStackview.isHidden = false
            
           // editVcRef?.viewDidLoad()
        //print("Segue for SearchController is Active now")
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
