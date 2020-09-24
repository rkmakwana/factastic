//
//  FeedsTableViewCell.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import UIKit

protocol FeedsCellView {
    func configure(with feed: Feed)
}

class FeedsTableViewCell: UITableViewCell {
    
    let topicImageView: CachedImageView = {
        let img = CachedImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        img.layer.borderWidth = 2.5
        img.layer.borderColor = UIColor.systemPink.cgColor
        return img
    }()
    
    let topicTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.title
        label.textColor = AppColors.primaryText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        return label
    }()
    
    let topicDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.subtitle
        label.textColor = AppColors.secondaryText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some description"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK:- FeedsCellView Protocol conformance
extension FeedsTableViewCell: FeedsCellView {
    
    func configure(with feed: Feed) {
        self.topicTitleLabel.text = feed.topic
        self.topicDetailsLabel.text = feed.detail
        
        self.topicImageView.image = nil
        self.topicImageView.backgroundColor = .systemPink
        if let imgURL = URL(string: feed.imageHref ?? "") {
            self.topicImageView.setImage(url: imgURL) { success in
                if success {
                    self.topicImageView.backgroundColor = .clear
                }
            }
            
        }
    }
    
}
