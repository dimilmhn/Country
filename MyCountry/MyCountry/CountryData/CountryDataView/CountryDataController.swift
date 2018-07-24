//
//  CountryDataController.swift
//  MyCountry
//
//  Created by Dimil T Mohan on 7/24/18.
//  Copyright © 2018 Dimil T Mohan. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class CountryDataController: UIViewController {
    @IBOutlet weak var countryDataTable: UITableView!
    var presenter = CountryDataPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryDataTable.estimatedRowHeight = 165.0
        self.countryDataTable.rowHeight = UITableViewAutomaticDimension
        presenter.delegate = self;
        presenter.fetchCountryData()
        
        ///testing
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        // Dispose of any resources that c
    
}
extension CountryDataController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = presenter.cointryDetails{
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ContryDataTableCell = tableView.dequeueReusableCell(withIdentifier: "ContryDetailListCellID", for: indexPath) as! ContryDataTableCell
        if let modelTitle = presenter.returnTheDataModelForIndex(index: indexPath.row)?.title {
            cell.title.text = modelTitle
        }
        else{
            cell.title.text = "Default Title"
        }
        if let modelDetails = presenter.returnTheDataModelForIndex(index: indexPath.row)?.details{
            cell.descriptionData.text = modelDetails
        }else{
            cell.descriptionData.text = "Default Description"
        }
        if let imageURL = presenter.returnTheDataModelForIndex(index: indexPath.row)?.imageURL{
            cell.detailImage.sd_setShowActivityIndicatorView(true)
            cell.detailImage.sd_setIndicatorStyle(.whiteLarge)
//            print("**************\(imageURL)")
            cell.detailImage.sd_setImage(with: NSURL(string:imageURL)! as URL, placeholderImage:#imageLiteral(resourceName: "Placeholder"), options: [.progressiveDownload,.continueInBackground])
        }else{
            cell.detailImage.image = #imageLiteral(resourceName: "Placeholder")
        }
        
        
        
        return cell
    }
    
}

extension CountryDataController:PresenterDelegate{
    func didFinishedTheFetch() {
        
        DispatchQueue.main.async { [unowned self] in
            self.countryDataTable.reloadData()
            self.title = self.presenter.viewTitle
        }
        
    }
}


class ContryDataTableCell: UITableViewCell {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var descriptionData: UILabel!;
    @IBOutlet weak var title: UILabel!
    
    
}
