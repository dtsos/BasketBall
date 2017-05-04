//
//  CountryViewController.swift
//  BasketBall Player
//
//  Created by David Trivian S on 5/3/17.
//  Copyright © 2017 David Trivian S. All rights reserved.
//

import UIKit
protocol CountryDelegate {
    func countrySelect(country:Country.Country)
    
}
class CountryCell : UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewCountry: UIImageView!
    
}
class CountryViewController: UITableViewController {
   public var delegate:CountryDelegate?
    var selectCountry:Country.Country = .none
    @IBAction func actionCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func country(indexCountry :Int) -> Country.Country{
        switch indexCountry {
        case 0:
            return .france
        case 1:
            return .germany
        case 2:
            return .usa
        case 3:
            return .spain
        case 4:
            return .australia
        default:
            return .none
        }
        
    }
    
   
    
    @IBAction func actionSelect(_ sender: UIButton) {
        delegate?.countrySelect(country: selectCountry)
         self.dismiss(animated: true, completion: nil)
    }
    var countries = ["France", "Germany", "USA","Spain","Australia"]
    var stringCountry:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexCountry =  countries.index(of: stringCountry.capitalized){
            let indexPath =  IndexPath.init(row: indexCountry, section: 0)
            tableView.selectRow(at:indexPath, animated: true, scrollPosition:UITableViewScrollPosition.none )
            tableView(self.tableView, didSelectRowAt: indexPath)
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCountry", for: indexPath) as! CountryCell
        
        let country = countries[indexPath.row]
        cell.labelName?.text = country
        cell.imageViewCountry?.image = UIImage(named: country.lowercased())
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCountry = country(indexCountry: indexPath.row)
        
    }
    
    
}
