//
//  MyTableViewController.swift
//  ListApp
//
//  Created by Mika Peer on 10/29/20.
//  Amended by Michelle Poon on 11/01/20.

import UIKit
import CoreData

class MyTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
        
    var MyStateListItems : [StateListAppItemMO] = []
   
    var fetchedResultsController : NSFetchedResultsController<StateListAppItemMO>!
    
    var searchController : UISearchController!
    var searchResults : [StateListAppItemMO] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add a search conroller and search bar to the app
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        let fetchRequest : NSFetchRequest<StateListAppItemMO> = StateListAppItemMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let context = appDelegate.persistentContainer .viewContext
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = self
            
            do {
                try fetchedResultsController.performFetch()
                if let fetchedObjects = fetchedResultsController.fetchedObjects{
                    MyStateListItems = fetchedObjects
                }
    
            } catch { print (error)
                
            }
            
            if MyStateListItems.count == 0 {
      
                let seedStateList = [StateListAppItem("Alabama", "Flag_of_Alabama", "Seal_of_Alabama", "AL", 52420.07, "Birmingham", "Birmingham", 4887871), StateListAppItem("Arizona", "Flag_of_Arizona", "Seal_of_Arizona", "AZ", 113990.3, "Phoenix", "Phoenix", 7171646), StateListAppItem("California", "Flag_of_California", "Seal_of_California", "CA", 163694.74, "Sacramento", "Los Angeles", 39557045), StateListAppItem("Delaware", "Flag_of_Delaware", "Seal_of_Delaware", "DE", 2488.72, "Wilmington", "Wilmington", 967171), StateListAppItem("Florida", "Flag_of_Florida", "Seal_of_Florida", "FL", 65757.7, "Tallahassee", "Jacksonville", 21299325), StateListAppItem("Hawaii", "Flag_of_Hawaii", "Seal_of_Hawaii", "HI", 10931.72, "Honolulu", "Honolulu", 1420491), StateListAppItem("Illinois", "Flag_of_Illinois", "Seal_of_Illinois", "IL", 57913.55, "Springfield", "Chicago", 12741080), StateListAppItem("Iowa", "Flag_of_Iowa", "Seal_of_Iowa", "IA", 56272.81, "Des Moines", "Des Moines", 3156145), StateListAppItem("Kentucky", "Flag_of_Kentucky", "Seal_of_Kentucky", "KY", 40407.8, "Frankfort", "Louisville", 4468402), StateListAppItem("Maine", "Flag_of_Maine", "Seal_of_Maine", "ME", 35379.74, "Augusta", "Portland", 1338404), StateListAppItem("Michigan", "Flag_of_Michigan", "Seal_of_Michigan", "MI", 96713.51, "Lansing", "Detroit", 9995915), StateListAppItem("Minnesota", "Flag_of_Minnesota", "Seal_of_Minnesota", "MN", 86935.83, "Minneapolis", "Minneapolis", 5611179), StateListAppItem("Missouri", "Flag_of_Missouri", "Seal_of_Missouri", "MO", 69706.99, "Jefferson City", "Kansas City", 6126452), StateListAppItem("Montana", "Flag_of_Montana", "Seal_of_Montana", "MT", 147039.71, "Helena", "Billings", 1062305), StateListAppItem("Nebraska", "Flag_of_Nebraska", "Seal_of_Nebraska", "NE", 77347.81, "Omaha", "Omaha", 1929268), StateListAppItem("Nevada", "Flag_of_Nevada", "Seal_of_Nevada", "NV", 110571.82, "Carson", "Las Vegas", 3034392), StateListAppItem("New York", "Flag_of_New_York", "Seal_of_New_York", "NY", 54554.98, "Albany", "New York City", 19542209), StateListAppItem("Ohio", "Flag_of_Ohio", "Seal_of_Ohio", "OH", 44825.58, "Columbus", "Columbus", 11689442), StateListAppItem("Oklahoma", "Flag_of_Oklahoma", "Seal_of_Oklahoma", "OK", 69898.87, "Oklahoma City", "Oklahoma City", 3943079), StateListAppItem("Tennessee", "Flag_of_Tennessee", "Seal_of_Tennessee", "TN", 42144.25, "Nashville", "Nashville", 6770010), StateListAppItem("Texas", "Flag_of_Texas", "Seal_of_Texas", "TX", 268596.46, "Houston", "Houston", 28701845), StateListAppItem("Utah", "Flag_of_Utah", "Seal_of_Utah", "UT", 84896.88, "Salt Lake City", "Salt Lake City", 3161105), StateListAppItem("Virginia", "Flag_of_Virginia", "Seal_of_Virginia", "VA", 42774.93, "Virginia Beach", "Virginia Beach", 8517685), StateListAppItem("Wisconsin", "Flag_of_Wisconsin", "Seal_of_Wisconsin", "WI", 65496.38, "Milwaukee", "Milwaukee", 5813568), StateListAppItem("Wyoming", "Flag_of_Wyoming", "Seal_of_Wyoming", "WY", 97813.01, "Cheyenne", "Cheyenne", 577737)]
        
    //    let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
     //   let context = (appDelegate?.persistentContainer .viewContext)!
                for seedItem in seedStateList {
                    let seedListItems = StateListAppItemMO(context: context)
                    seedListItems.name = seedItem.name
                    seedListItems.flag = seedItem.flag
                    seedListItems.seal = seedItem.seal
                    seedListItems.abbreviation = seedItem.abbreviation
                    seedListItems.area = seedItem.area
                    seedListItems.capitol = seedItem.capitol
                    seedListItems.largestCity = seedItem.largestCity
                    seedListItems.population = Int32(seedItem.population)
                    
                    appDelegate.saveContext()
                }
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case.insert:
            if let insertIndexPath = indexPath {
                tableView.insertRows(at: [insertIndexPath], with: .fade)
            }
        
        case.delete:
            if let deleteIndexPath = indexPath {
                tableView.deleteRows(at: [deleteIndexPath], with: .fade)
            }
            
        case.update:
            if let changeIndexPath = indexPath {
                tableView.reloadRows(at: [changeIndexPath], with: .fade)
            }
            
        default:
            tableView.reloadData()
        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, , return the number of rows
      
        if searchController.isActive {
            return searchResults.count
        }
        else {
            return MyStateListItems.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "StateCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell

        var cellItem : StateListAppItemMO
        if searchController.isActive {
            cellItem = searchResults[indexPath.row]
        }
        else {
            cellItem = MyStateListItems[indexPath.row]
        }
        
        // Configure the cell...
        // assign the values to the cell when touch
        cell.stateName?.text = cellItem.name
        
       // cell.stateName?.text = MyStateListItems[indexPath.row].name
        cell.cellImage?.clipsToBounds = true
        cell.cellImage?.layer.masksToBounds = true
        cell.cellImage?.image = UIImage(named: MyStateListItems[indexPath.row].flag ?? "Flag_of_Alabama")
        
        cell.alpha = 0
        UIView.animate(withDuration: 5, animations: { cell.alpha = 1})
        return cell
        
    }
    
    //there is a bug in the code we probably should not use the check mark
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none {
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else {
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
    */
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let selectedItem = ListOfStates[indexPath.row]
//
//        let doneAlert = UIAlertController(title: selectedItem, message: "detail State info", preferredStyle: UIAlertController.Style.alert)
//
//        doneAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//        self.present(doneAlert, animated:
//                        true, completion:{ if self.tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none  {self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark}
//                        else { self.tableView.cellForRow(at: indexPath)?.accessoryType = .none}
//                        })
//    }
//
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete data from the model first
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let deleteItem = self.fetchedResultsController.object(at: indexPath)
                context.delete(deleteItem)
                appDelegate.saveContext()
            }
//            ListOfStates.remove(at: indexPath.row)
//            StateImages.remove(at: indexPath.row)

            // Delete the row from the data source
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStates" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! ViewController
                detailVC.imgFlag = UIImage(named: MyStateListItems[indexPath.row].flag ?? "Flag_of_Alabama")
                detailVC.imgSeal = UIImage(named: MyStateListItems[indexPath.row].seal ?? "Seal_of_Alabama")
                detailVC.strNameAbbreviation = "   " + MyStateListItems[indexPath.row].name! + " : " + MyStateListItems[indexPath.row].abbreviation!
                detailVC.strCapitol = " Capitol : " + MyStateListItems[indexPath.row].capitol!
                detailVC.strLargestCity = " Largest City : " + MyStateListItems[indexPath.row].largestCity!
                
                // set up for number formatting
                let numberFormat = NumberFormatter()
                numberFormat.usesGroupingSeparator = true
                numberFormat.groupingSize = 3
                numberFormat.groupingSeparator = ","
                detailVC.strPopulation = " Population : \(String(numberFormat.string(for: MyStateListItems[indexPath.row].population)!))"
                
                // set up number formatting to accomodate decimal places as in the data.
                numberFormat.numberStyle = .decimal
                detailVC.strArea = " Area : \(String(numberFormat.string(for: MyStateListItems[indexPath.row].area)!)) sq mi"
            }
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let textToSearch = searchController.searchBar.text {
            filterContentForSearchText(searchText: textToSearch)
            tableView.reloadData()
        }
    }
    func filterContentForSearchText(searchText: String){
        searchResults = MyStateListItems.filter({ (searchItem: StateListAppItemMO) -> Bool in
            let nameMatch = searchItem.name?.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            return nameMatch != nil
        })
    }
}
