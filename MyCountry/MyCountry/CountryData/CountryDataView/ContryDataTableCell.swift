//
//  ContryDataTableCell.swift
//  MyCountry
//
//  Created by Dimil T Mohan on 7/24/18.
//  Copyright © 2018 Dimil T Mohan. All rights reserved.
//

/*
 Having the UIKit reference
 Interract with presenter for the data
 No Model contact
 */
import Foundation
import UIKit

class ContryDataTableCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Create view
        self.contentView.addSubview(detailImage)
        self.contentView.addSubview(title)
        self.contentView.addSubview(descriptionData)
        self.contentView.addSubview(hiddenView)
        
        //Setting the constraints for the view
        
        detailImage.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:23).isActive = true
        detailImage.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:14).isActive = true
        detailImage.widthAnchor.constraint(equalToConstant:128).isActive = true
        detailImage.heightAnchor.constraint(equalToConstant:128).isActive = true
        
        hiddenView.topAnchor.constraint(equalTo:self.detailImage.bottomAnchor).isActive = true
        hiddenView.leadingAnchor.constraint(equalTo:self.detailImage.leadingAnchor).isActive = true
        hiddenView.widthAnchor.constraint(equalToConstant:128).isActive = true
        hiddenView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant:-14).isActive = true
        
        
        title.topAnchor.constraint(equalTo:self.detailImage.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo:detailImage.trailingAnchor, constant:24).isActive = true
        title.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-15).isActive = true
        title.heightAnchor.constraint(equalToConstant:23).isActive = true
        
        descriptionData.topAnchor.constraint(equalTo:self.title.bottomAnchor, constant:2).isActive = true
        descriptionData.leadingAnchor.constraint(equalTo:detailImage.trailingAnchor, constant:24).isActive = true
        descriptionData.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-15).isActive = true
        descriptionData.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant:-19).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    let detailImage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let title:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionData:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let hiddenView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
}
