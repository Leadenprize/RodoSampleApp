//
//  InventoryList.swift
//  RodoSampleApp
//
//  Created by Daniel Perez on 1/25/23.
//

import Foundation

enum LoadObjectError: Error {
    case filefoundIssue
    case fileformatIssue
    case filereadIssue
}

protocol KeyCodingValued {
    func valueByPropertyName(name:String)->Any
    
}


struct FilterParameter<T>{
    var elementName:String
    var elementOption1:T?
    var elementOption2:T?
    init(_ arg1:String,option1:T,option2:T){
        elementName = arg1;
        elementOption1 = option1
        elementOption2 = option2
    }
    init(_ arg1:String,option1:T){
        elementName = arg1;
        elementOption1 = option1
    }
    init(_ arg1:String,option2:T){
        elementName = arg1;
        elementOption1 = option2
    }
    init(_ arg1:String,floor:T){
        elementName = arg1;
        elementOption1 = floor
    }
    init(_ arg1:String,ceiling:T){
        elementName = arg1;
        elementOption2 = ceiling
    }
    init(_ arg1:String,searchString:T){
        elementName = arg1;
        elementOption1 = searchString
    }
    
}


struct CarItem : Codable,KeyCodingValued {
    var make: String
    var model: String
    var year: Int
    var vehicle_count: Int
    var price: Int
    func valueByPropertyName(name:String)->Any{
        switch name{
        case "make": return make
        case "model": return model
        case "year": return year
        case "vehicle_count": return vehicle_count
        case "price": return price
        default: return ""
        }
    }
}

class InventoryListModel<T:KeyCodingValued&Codable>  {
    var inventoryItems:[T] = []
    
    func filterWithSearchFilters( searchFilters:[Any] )->[T]{
        // option1 and option2 are || searches when String
        // option1 <= value <= option2 when searches are Int
        // Add More FilterParameter<T> to support more searchTypes
        var resultItems:[T] = []
        itemLoop:for item in inventoryItems {
            var matches:Bool = true;
            searchLoop:for searchFilter in searchFilters {
                switch searchFilter {
                case let filterParameter as FilterParameter<String>:
                    let nameOfElement:String = filterParameter.elementName
                    let searchString:String = filterParameter.elementOption1 ?? ""
                    let searchString2:String = filterParameter.elementOption2 ?? ""
                    // Search String
                    
                    let value:String = (item.valueByPropertyName(name: nameOfElement) as? String ) ?? ""
                    if( searchString2 == "" && value.contains(searchString) == false ){
                        matches = false
                        break searchLoop
                    }
                    else if( searchString == "" && value.contains(searchString2) == false ){
                        matches = false
                        break searchLoop
                    }
                    else if( ( searchString != "" && value.contains(searchString) == false ) &&
                             ( searchString2 != "" && value.contains(searchString2) == false  )){
                        matches = false
                        break searchLoop
                    }
                    else{
                        // Matched
                        //       print( "\(value) matches \(searchString),\(searchString2) for \(nameOfElement)")
                    }
                case let filterParameter as FilterParameter<Int>:
                    let nameOfElement:String = filterParameter.elementName
                    let lowValue:Int? = filterParameter.elementOption1
                    let highValue:Int? =  filterParameter.elementOption2
                    let value:Int = (item.valueByPropertyName(name: nameOfElement) as? Int ) ?? 0
                    if( ( lowValue == nil || value >= lowValue ?? 0 ) &&
                        ( highValue == nil || value <= highValue ?? 0 )
                    ){
                    //    print( "\(lowValue) < \(value) < \(highValue) for \(nameOfElement)")
                    }
                    else{
                        matches = false
                        break searchLoop

                    }
                default:
                    print("Invalid searchFilter, must be searchParamter supported Type")
                }
              
            }
            if( matches ){
                resultItems.append( item )
            }
            
        }
        
        return resultItems;
        
    }
    
}
    

    


func loadObjectFromBundle<T:Decodable>(_ filename: String ) throws -> T  {
    let data : Data
    guard let file = Bundle.main.url( forResource: filename, withExtension: nil ) else{
        throw LoadObjectError.filefoundIssue
        
    }
    do {
        data = try Data(contentsOf: file )
    } catch {
        throw LoadObjectError.filereadIssue
    }
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from:data )
    } catch {
        throw LoadObjectError.fileformatIssue
    }
}
  
    
