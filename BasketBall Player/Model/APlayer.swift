//
//  APlayer.swift
//  BasketBall Player
//
//  Created by David Trivian S on 5/2/17.
//  Copyright © 2017 David Trivian S. All rights reserved.
//

import Foundation
import CoreData

class Country {
    public enum Country {
        case france
        case germany
        case usa
        case spain
        case australia
        case none
    }
}

class APlayer {
    init(player:Player?,_ context:NSManagedObjectContext){
        self.player =  player
        self.age = (player?.age) ?? 0
        self.name =  player?.name ?? ""
        self.weight =  player?.weight ?? 0
        self.height =  player?.height ?? 0
        self.country =  player?.country ?? ""
        self.context = context
    }
    
    var player: Player? = nil
   
    var name: String? {
        willSet {
            
            self.player?.name = newValue
        }
    }
    
    
    
    var age :  Int16? {
        willSet {
            
            self.player?.age = newValue ?? 0
        }
    }

    var weight : Float? {
        willSet {
            
            self.player?.weight = newValue ?? 0
        }
    }
    var height : Float? {
        willSet {
            
            self.player?.height = newValue ?? 0
        }
    }
    var country : String?{
        willSet {
            
            self.player?.country = newValue ?? ""
        }
    }
    var context : NSManagedObjectContext
    func countryPlayer(countryPlayer: Country.Country){
        var stringCountry = ""
        switch countryPlayer {
        case .france:
            stringCountry = "France"
        case .germany:
            stringCountry = "Germany"
        case .usa:
            stringCountry = "USA"
        case .spain:
            stringCountry = "Spain"
        case .australia:
            stringCountry = "Australia"
        default :
            stringCountry = ""
            
        }
        
        self.country =  stringCountry
    }
    func save() {
        if self.player == nil {
            
            self.player =  Player(context: self.context)
            self.player?.age = self.age ?? 0
            self.player?.name = self.name
            self.player?.weight =  self.weight ?? 0
            self.player?.height = self.height ?? 0
            self.player?.country = self.country
            
            
            
        }
        self.player?.dateModified = NSDate()
        do {
            try context.save()
        } catch  {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    
}
