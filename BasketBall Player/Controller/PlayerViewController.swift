//
//  PlayerViewController.swift
//  BasketBall Player
//
//  Created by David Trivian S on 5/1/17.
//  Copyright © 2017 David Trivian S. All rights reserved.
//

import UIKit
import CoreData
class PlayerViewController: UIViewController,CountryDelegate {
    var fecthRequestCOntroller : NSFetchedResultsController<Player>?
    var aPlyerModel :APlayer?
    var player: Player?
    var selectedCountry:Country.Country = .none
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationController?.navigationItem.title = "Player"
        self.aPlyerModel =  APlayer.init(player: self.player, (self.fecthRequestCOntroller?.managedObjectContext)!)
        
        if self.player != nil {
            self.textFieldName.text =  self.player?.name ?? ""
            self.textFieldWeight.text =  self.player?.weight.description
            self.textFieldHeight.text =  self.player?.height.description
            self.textFieldCountry.text =  self.player?.country ?? nil
            self.textFieldAge.text =  self.player?.age.description
        }
        
    }
    
    @IBAction func actionNameChanged(_ sender: UITextField) {
        self.aPlyerModel?.name = sender.text!
    }
    
    
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var textFieldCountry: UITextField!
    @IBOutlet weak var textFieldHeight: UITextField!
    
    @IBOutlet weak var textFieldWeight: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    func alertShow(_ string:String) {
        let actionSheetController: UIAlertController = UIAlertController(title: "", message: string, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            
        }
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    @IBAction func actionSave(_ sender: UIBarButtonItem) {
        if (textFieldName.text?.characters.count)! <= 0 {
            self .alertShow("Name cannot be empty")
            return
        }
        if (textFieldWeight.text?.characters.count)! <= 0 {
            self .alertShow("Weight cannot be empty")
            return
        }
        if (textFieldHeight.text?.characters.count)! <= 0 {
            self .alertShow("Height cannot be empty")
            return
        }
        
        if (textFieldCountry.text?.characters.count)! <= 0 {
            self .alertShow("Country cannot be empty")
            return
        }
        if (textFieldAge.text?.characters.count)! <= 0 {
            self .alertShow("Age cannot be empty")
            return
        }
        self.aPlyerModel?.name = self.textFieldName.text!
          self.aPlyerModel?.age = Int16(self.textFieldAge.text!)
         self.aPlyerModel?.weight = Float(self.textFieldWeight.text!)
        self.aPlyerModel?.height = Float(self.textFieldHeight.text!)

        self.aPlyerModel?.save()
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectCountry" {
            let navcontroller = segue.destination as! UINavigationController
            if let viewController:CountryViewController = navcontroller.viewControllers[0] as? CountryViewController  {
                viewController.stringCountry = self.textFieldCountry.text!
                viewController.delegate = self 
            }
        }
    }
    
    func countrySelect(country:Country.Country){
        
        self.aPlyerModel?.countryPlayer(countryPlayer: country)
        self.textFieldCountry.text =  self.aPlyerModel?.country
    }

}
