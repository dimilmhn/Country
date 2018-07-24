//
//  CountryDataPresenter.swift
//  MyCountry
//
//  Created by Dimil T Mohan on 7/24/18.
//  Copyright © 2018 Dimil T Mohan. All rights reserved.
//

import Foundation
protocol PresenterDelegate: class {
    func didFinishedTheFetch()
}
class CountryDataPresenter: NSObject {
    
    var manager = CountryDataManager()
    var cointryDetails:[CountryDataContents]?
    var viewTitle:String?
    weak var delegate:PresenterDelegate?
    
    
    override init() {
        
    }
    
    func fetchCountryData(){
        manager.requestContryData{data in
            if let dataList = data?.dataList{
                self.cointryDetails = dataList
            }
            if let viewTitle = data?.title{
                self.viewTitle = viewTitle
            }
            self.delegate?.didFinishedTheFetch()
            
        }
    }
    
    func returnTheDataModelForIndex(index:Int) -> CountryDataContents?{
        return self.cointryDetails![index]
    }
}
