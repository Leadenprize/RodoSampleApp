//
//  RodoSampleAppTests.swift
//  RodoSampleAppTests
//
//  Created by Daniel Perez on 1/25/23.
//

import XCTest
@testable import RodoSampleApp

final class RodoSampleAppTests: XCTestCase {

    var inventoryListModel:InventoryListModel<CarItem>!
    var homeViewControllerViewModel:HomeViewControllerViewModel!
    
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        inventoryListModel = InventoryListModel<CarItem>()
        
        inventoryListModel.inventoryItems = try loadObjectFromBundle("Exercise_Dataset.json")
        XCTAssertTrue( inventoryListModel.inventoryItems.count > 0 )
        
        homeViewControllerViewModel = HomeViewControllerViewModel()
        homeViewControllerViewModel.inventoryListModel = inventoryListModel
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        
    }

    func testExample() throws {
        
        var searchFilters:[Any] = []
        searchFilters.append( FilterParameter<String>("make",option1: "Ford", option2: "" ) )
        searchFilters.append( FilterParameter<String>("model",option1: "", option2:"Mustang" ) )
        var resultList:[CarItem] = homeViewControllerViewModel.searchInventoryList(searchFilters: searchFilters )
        XCTAssertTrue( resultList.count > 0 )
        let numberOfFord = resultList.count
        searchFilters.removeAll()
        searchFilters.append( FilterParameter<String>("make",option1: "Ford", option2: "" ) )
        searchFilters.append( FilterParameter<String>("model",option1: "", option2:"Lamborghini" ) )
        resultList = homeViewControllerViewModel.searchInventoryList(searchFilters: searchFilters )
        XCTAssertTrue( resultList.count == 0 )
        
        searchFilters.removeAll()
        searchFilters.append( FilterParameter<String>("make",option1: "Volks", option2: "Ford" ) )
        resultList = homeViewControllerViewModel.searchInventoryList(searchFilters: searchFilters )
        XCTAssertTrue( resultList.count > numberOfFord )
        
        searchFilters.removeAll()
        searchFilters.append( FilterParameter<String>("make",option1: "Volkswa", option2: "" ) )
        resultList = homeViewControllerViewModel.searchInventoryList(searchFilters: searchFilters )
        XCTAssertTrue( resultList.count > 0 )
        
      
        
        searchFilters.removeAll()
        searchFilters.append( FilterParameter<String>("make",option1: "Ford", option2: "" ) )
        searchFilters.append( FilterParameter<Int>("price",option1: 20000) )
        resultList = homeViewControllerViewModel.searchInventoryList(searchFilters: searchFilters )
        resultList = resultList.sorted{  $0.price < $1.price }
        XCTAssertTrue( resultList[0].price > 20000 )
        
        searchFilters.removeAll()
        searchFilters.append( FilterParameter<String>("make",option1: "Ford", option2: "" ) )
        searchFilters.append( FilterParameter<Int>("price",option1: 80000) )
        resultList = homeViewControllerViewModel.searchInventoryList(searchFilters: searchFilters )
        resultList = resultList.sorted{  $0.price < $1.price }
         XCTAssertTrue( resultList[0].price > 80000 )
      
        searchFilters.removeAll()
        searchFilters.append( FilterParameter<String>("make",option1: "Ford", option2: "" ) )
        searchFilters.append( FilterParameter<Int>("price",option1: 80000 ,option2: 78000) )
        resultList = homeViewControllerViewModel.searchInventoryList(searchFilters: searchFilters )
        resultList = resultList.sorted{  $0.price < $1.price }
         XCTAssertTrue( resultList.count == 0 )
        
        searchFilters.removeAll()
        searchFilters.append( FilterParameter<String>("make",option1: "Ford", option2: "" ) )
        searchFilters.append( FilterParameter<Int>("price",option1: 50000 ,option2: 78000) )
        
        resultList = homeViewControllerViewModel.searchInventoryList(searchFilters: searchFilters )
        resultList = resultList.sorted{  $0.price < $1.price }
        XCTAssertTrue( resultList[0].price > 50000 )
        XCTAssertTrue( resultList[resultList.count-1].price < 78000 )
       
        searchFilters.removeAll()
        searchFilters.append( FilterParameter<String>("make",option1: "Ford", option2: "" ) )
        searchFilters.append( FilterParameter<Int>("year",option1: 2019 ,option2: 2019 ) )
        resultList = homeViewControllerViewModel.searchInventoryList(searchFilters: searchFilters )
        resultList = resultList.sorted{  $0.price < $1.price }
        XCTAssertTrue( resultList.count < 30 )
       
        searchFilters.removeAll()
        searchFilters.append( FilterParameter<String>("make",option1: "Ford", option2: "" ) )
        resultList = homeViewControllerViewModel.searchInventoryList(searchFilters: searchFilters )
        resultList = resultList.sorted{  $0.price < $1.price }
        XCTAssertTrue( resultList.count > 30 )
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    //
}
