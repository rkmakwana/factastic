//
//  FeedsTableViewCellUILayout.swift
//  Factastic
//
//  Created by Rashmikant Makwana on 24/09/20.
//  Copyright © 2020 Rashmikant Makwana. All rights reserved.
//

import UIKit

extension FeedsTableViewCell {
    
    func createLayout() {
        self.contentView.addSubview(topicImageView)
        
        var constraints = [
            topicImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            topicImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            topicImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            topicImageView.widthAnchor.constraint(equalToConstant: 60.0),
            topicImageView.heightAnchor.constraint(equalToConstant:60.0)
        ]
        
        self.contentView.addSubview(topicTitleLabel)
        constraints.append(contentsOf: [
            topicTitleLabel.topAnchor.constraint(equalTo: topicImageView.topAnchor),
            topicTitleLabel.leadingAnchor.constraint(equalTo:topicImageView.trailingAnchor, constant: 20),
            topicTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        self.contentView.addSubview(topicDetailsLabel)
        constraints.append(contentsOf: [
            topicDetailsLabel.topAnchor.constraint(equalTo: topicTitleLabel.bottomAnchor, constant: 5),
            topicDetailsLabel.leadingAnchor.constraint(equalTo:topicTitleLabel.leadingAnchor),
            topicDetailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            topicDetailsLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
    
        NSLayoutConstraint.activate(constraints)
    }
    
}
