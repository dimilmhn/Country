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
    var indicatorView = UIView()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(CountryDataController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    
    // MARK: LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTheTable()
        presenter.delegate = self;
        indicatorView = UIViewController.displaySpinner(onView: self.view)
        presenter.fetchCountryData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: General methods
    func configureTheTable(){
        self.countryDataTable.estimatedRowHeight = 165.0
        self.countryDataTable.rowHeight = UITableViewAutomaticDimension
        self.countryDataTable.addSubview(self.refreshControl)
        self.countryDataTable.isHidden = true

    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter.fetchCountryData()
        self.countryDataTable.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: UITableViewDataSource
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
            cell.title.text = "Title not available"
        }
        if let modelDetails = presenter.returnTheDataModelForIndex(index: indexPath.row)?.details{
            cell.descriptionData.text = modelDetails
        }else{
            cell.descriptionData.text = "Description not available"
        }
        if let imageURL = presenter.returnTheDataModelForIndex(index: indexPath.row)?.imageURL{
            cell.detailImage.sd_setShowActivityIndicatorView(true)
            cell.detailImage.sd_setIndicatorStyle(.white)
            cell.detailImage.sd_setImage(with: NSURL(string:imageURL)! as URL, placeholderImage:#imageLiteral(resourceName: "Placeholder"), options: [.progressiveDownload,.continueInBackground])
        }else{
            cell.detailImage.image = #imageLiteral(resourceName: "Placeholder")
        }
  
        return cell
    }
    
}
// MARK: PresenterDelegate
extension CountryDataController:PresenterDelegate{
    func didFinishedTheFetch() {
        
        DispatchQueue.main.async { [unowned self] in
            UIViewController.removeSpinner(spinner:self.indicatorView)
            self.countryDataTable.isHidden = false
            self.countryDataTable.reloadData()
            self.title = self.presenter.viewTitle
        }
        
    }
}



