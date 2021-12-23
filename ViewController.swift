/*
//
//  ViewController.swift
//  ChangeViews
//
//  Created by Mika Peer on 12/9/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeView(_ sender: Any) {
        self.performSegue(withIdentifier: "changeSegue", sender: self)
    
    }
    
}

*/

//
//  ViewController.swift
//  ListApp
//
//  Created by Mika Peer on 10/29/20.
//  Amended by Michelle Poon on 11/01/20.

import UIKit

class ViewController: UIViewController {

    // outlets related to detail page
    @IBOutlet weak var stateFlag: UIImageView!
    @IBOutlet weak var stateSeal: UIImageView!
    
    @IBOutlet weak var stateNameAbbreviation: UILabel!
    @IBOutlet weak var stateCapitol: UILabel!
    @IBOutlet weak var stateLargestCity: UILabel!
    @IBOutlet weak var statePopulation: UILabel!
    @IBOutlet weak var stateArea: UILabel!
    
    // variables to hold values to be displayed
    var imgFlag : UIImage!
    var imgSeal : UIImage!
    var strNameAbbreviation : String!
    var strCapitol : String!
    var strLargestCity : String!
    var strPopulation : String!
    var strArea : String!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        var rotationTransform : CATransform3D = CATransform3DIdentity
        rotationTransform = CATransform3DTranslate(rotationTransform, -250, -250, 0)
        stateArea.layer.transform = rotationTransform
        statePopulation.layer.transform = rotationTransform
        stateLargestCity.layer.transform = rotationTransform
        stateCapitol.layer.transform = rotationTransform
        stateNameAbbreviation.layer.transform = rotationTransform

        UIView.animate(withDuration: 3, animations: {
            self.stateArea.layer.transform = CATransform3DIdentity
            self.statePopulation.layer.transform = CATransform3DIdentity
            self.stateLargestCity.layer.transform = CATransform3DIdentity
            self.stateCapitol.layer.transform = CATransform3DIdentity
            self.stateNameAbbreviation.layer.transform = CATransform3DIdentity
        
        })
        
        stateFlag.alpha = 0
        UIView.animate(withDuration: 5, animations: { self.stateFlag.alpha = 1})
        stateSeal.alpha = 0
        UIView.animate(withDuration: 5, animations: { self.stateSeal.alpha = 1})
        
        // Do any additional setup after loading the view.
        stateArea.layer.borderWidth = 2.0
        stateArea.layer.masksToBounds = true
        stateArea.layer.borderColor = UIColor.gray.cgColor
      
        statePopulation.layer.borderWidth = 2.0
        statePopulation.layer.masksToBounds = true
        statePopulation.layer.borderColor = UIColor.gray.cgColor
        
        stateLargestCity.layer.borderWidth = 2.0
        stateLargestCity.layer.masksToBounds = true
        stateLargestCity.layer.borderColor = UIColor.gray.cgColor
        
        stateCapitol.layer.borderWidth = 2.0
        stateCapitol.layer.masksToBounds = true
        stateCapitol.layer.borderColor = UIColor.gray.cgColor
        
        stateNameAbbreviation.layer.borderWidth = 2.0
        stateNameAbbreviation.layer.masksToBounds = true
        stateNameAbbreviation.layer.borderColor = UIColor.gray.cgColor
        
        // assign values to the outlet to be displayed
        self.stateFlag.image = self.imgFlag
        self.stateSeal.image = self.imgSeal
        self.stateNameAbbreviation.text = self.strNameAbbreviation
        self.stateCapitol.text = self.strCapitol
        self.stateLargestCity.text = self.strLargestCity
        self.statePopulation.text = self.strPopulation
        self.stateArea.text = self.strArea
         
      
    }


    @IBAction func showMap(_ sender: Any) {
        self.performSegue(withIdentifier: "showMap", sender: self)
        print("working plz smile")
    }
    
    
}

