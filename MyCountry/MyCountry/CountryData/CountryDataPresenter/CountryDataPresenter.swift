//
//  CountryDataPresenter.swift
//  MyCountry
//
//  Created by Dimil T Mohan on 7/24/18.
//  Copyright © 2018 Dimil T Mohan. All rights reserved.
//

/*
 Having the Model reference
 Interract with Model layer for the data
 Handling the presenter logic
 No UIKit Reference
 */
import Foundation
protocol PresenterDelegate: class {
    func didFinishedTheFetch()
    func didFinishedWithError(error:Any?)
    
}
class CountryDataPresenter: NSObject {
    
    var manager = CountryDataManager()
    var cointryDetails:[CountryDataContents]?
    var viewTitle:String?
    weak var delegate:PresenterDelegate?
    
    
    override init() {
        
    }
    
    //Requesting data to Manager
    func fetchCountryData(){
        manager.requestContryData(completion :{data in
            if let dataList = data?.dataList{
                self.cointryDetails = dataList
            }
            if let viewTitle = data?.title{
                self.viewTitle = viewTitle
            }
            self.delegate?.didFinishedTheFetch()
        }, andError: {error in
            self.delegate?.didFinishedWithError(error: error)
        })
    }

    //Logic for mapping the UI
    func returnTheDataModelForIndex(index:Int) -> CountryDataContents?{
        if (self.cointryDetails) != nil{
            return self.cointryDetails?[index]
        }
        return nil
    }
}
