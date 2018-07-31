//
//  CountryDataManager.swift
//  MyCountry
//
//  Created by Dimil T Mohan on 7/24/18.
//  Copyright © 2018 Dimil T Mohan. All rights reserved.
//
/*
 Interract with core network layer for the data
 Handling the Buiciness logic and generating the model 
 */
import Foundation
class CountryDataManager: NSObject {
    
    func requestContryData(completion: @escaping (CountryDataModel?) -> Void,andError completionError: @escaping  (Any?) -> Void){
        print(APP_URLS.Country_Data_URL)
        CoreNetworkService().requestGetData(url:APP_URLS.Country_Data_URL, completion: {response in
            if (response != nil){
                let responseStrInISOLatin = String(data: response! as! Data, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    print("could not convert data to UTF-8 format")
                    return
                }
                let json = try? JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                let dataDic = json as! Dictionary<String, Any>
                
                if let countryData = dataDic["rows"]as? [Dictionary<String, Any>]{
                    var list = [CountryDataContents]()
                    // Accepts a dictionary
                    let closure: (Dictionary<String, Any>) -> CountryDataContents?
                    // Initializing the closure
                    closure = { dictionary in
                        return CountryDataContents(dictionary: dictionary)
                    }
                    // Higher order function(compactMap) execution
                    list = countryData.compactMap(closure)
                    print(list)
                    if (list.count != 0) ,let header = dataDic["title"] as? String{
                        let content = CountryDataModel(title:header , contentList: list)
                        completion(content)
                    }
                    else{
                        completion(nil)
                    }
                }
                completion(nil)
            }
            completion(nil)
        }, andError: {error in
            completionError(error)
        })
        
    }
 
}


struct CountryDataContents {
    var details:String?
    var title:String?
    var imageURL:String?
    
    // failable initalizer
    init?(dictionary: Dictionary<String, Any>) {
        if let decsription = dictionary["description"] as? String{
            self.details = decsription
        }
        if let title = dictionary["title"] as? String{
            self.title = title
        }
        
        if let imageRef = dictionary["imageHref"] as? String{
            self.imageURL = imageRef
        }
    }
}
struct CountryDataModel {
    var title:String?
    var dataList:[CountryDataContents]?
    init?(title:String?,contentList:[CountryDataContents]) {
        if let title = title{
            self.title = title;
        }
        else{
            self.title = ""
        }
        if(contentList.count != 0){
            self.dataList = contentList
        }
    }
}
