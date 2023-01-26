//
//  HomeViewControllerViewModel.swift
//  RodoSampleApp
//
//  Created by Daniel Perez on 1/25/23.
//

import Foundation
import UIKit

class HomeViewControllerViewModel {
    
    var searchMakeAndModel: String = ""

    var inventoryListModel:InventoryListModel<CarItem>?
    
    func setupInventory(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        inventoryListModel = appDelegate.carInventoryListModel
    }
    
    
    func searchInventory()->[String:Int]{
        var searchFilters:[Any] = []
        
        var optionalString1 = searchMakeAndModel
        var optionalString2 = ""
        // In case they put in the make and model out of order, we will try to break it into two parts
        // Put searchFilters in order of the search, so for optimization do most stringent filter first
        
        let optionalStrings = searchMakeAndModel.split(separator: " ",maxSplits: 1).map(String.init)
        var resultList:[CarItem]
        if( optionalStrings.count > 1){
            // MULTI WORD, LET'S TRY ASSUMING THAT THE FIRST WORD IS MAKE AND THE SECOND+ WORDS COULD BE MODEL, OR ALTERNATE
            optionalString1 = optionalStrings[0]
            optionalString2 = optionalStrings[1]
            searchFilters.append( FilterParameter<String>("make",option1: optionalString1, option2: "" ) )
            searchFilters.append( FilterParameter<String>("model",option1: "", option2:optionalString2 ) )
            resultList = searchInventoryList(searchFilters: searchFilters )
            if( resultList.count == 0 ){
                searchFilters.removeAll()
                searchFilters.append( FilterParameter<String>("model",option1: optionalString1, option2: "" ) )
                searchFilters.append( FilterParameter<String>("make",option1: "", option2:optionalString2 ) )
                resultList = searchInventoryList(searchFilters: searchFilters )
            }
        }
        else{
            // ONE WORD SEARCH NO SPACES, FIRST TRY MAKE THEN TRY MODEL
            searchFilters.append( FilterParameter<String>("make",option1: optionalString1, option2: "" ) )
            resultList = searchInventoryList( searchFilters: searchFilters )
            if( resultList.count == 0 ){
                searchFilters.removeAll()
                searchFilters.append( FilterParameter<String>("model",option1: optionalString1, option2: "" ) )
                resultList = searchInventoryList( searchFilters: searchFilters )
            }
        }
        
        
        if( resultList.count == 0 ){
            // LAST TRY SO ASSUME THEY ENTERED A MULTIWORD MODEL OR A MULTIWORD MAKE
            searchFilters.removeAll()
            searchFilters.append( FilterParameter<String>("model",option1: searchMakeAndModel, option2: "" ) )
            resultList = searchInventoryList( searchFilters: searchFilters )
            
            if( resultList.count == 0 ){
                searchFilters.removeAll()
                searchFilters.append( FilterParameter<String>("make",option1: searchMakeAndModel, option2: "" ) )
                resultList = searchInventoryList( searchFilters: searchFilters )
            }
        }
        // Calculate and return
        // Total Number of vehicles available that matches the faceted search parameters
        // Find the Lowest, Median, and Highest Price of the vehicle that matches the price
        resultList = resultList.sorted{  $0.price < $1.price }

        var totalNumberOfVehicles:Int = 0
        var lowestPrice:Int = 0
        var medianPrice:Int = 0
        var highestPrice:Int = 0
        if( resultList.count > 0 ){
            totalNumberOfVehicles = resultList.reduce(0){ $0+$1.vehicle_count }
            if( resultList.count % 2 == 0 || resultList.count == 1 ){
                medianPrice = resultList[ resultList.count/2].price
            }
            else{
                medianPrice = ( resultList[ resultList.count/2].price+resultList[ (resultList.count/2)+1].price )/2
            }
            lowestPrice = resultList.first?.price ?? 0
            highestPrice = resultList.last?.price ?? 0
        }
        
        // PRINT RESULTS?
        guard let jsonData = try? JSONEncoder().encode(resultList) else {
            return [:]
        }
        print(String(bytes: jsonData, encoding: String.Encoding.utf8) ?? "")
        
        // PRINT RETURN PARAMETERS
        let results = ["totalNumberOfVehicles":totalNumberOfVehicles,
                       "lowestPrice":lowestPrice,
                       "highestPrice":highestPrice,
                       "medianPrice":medianPrice
                    ]
        guard let resultsjsonData = try? JSONEncoder().encode(results) else {
            return [:]
        }
        print(String(bytes: resultsjsonData, encoding: String.Encoding.utf8) ?? "")
        
        // RETURN JSON
        return results
        
    }
    
    func searchInventoryList(searchFilters:[Any])->[CarItem]{
        guard let inventoryList:InventoryListModel<CarItem> = inventoryListModel else{
            return []
        }
        let inventoryListResults:[CarItem] = inventoryList.filterWithSearchFilters( searchFilters: searchFilters)
        
        return inventoryListResults
    }
}
