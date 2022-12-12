//
//  TestCell.swift
//  ElephantV2
//
//  Created by Lionel Yu on 12/11/22.
//

import UIKit

class TestCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var compLabel: UIButton!
    @IBOutlet weak var projLabel: UILabel!
    @IBOutlet weak var editLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: compLabel.topAnchor),

            compLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            compLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            compLabel.trailingAnchor.constraint(equalTo: editLabel.leadingAnchor),
            compLabel.bottomAnchor.constraint(equalTo: projLabel.topAnchor),
            
            editLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            editLabel.leadingAnchor.constraint(equalTo: compLabel.trailingAnchor),
            editLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            editLabel.bottomAnchor.constraint(equalTo: projLabel.topAnchor),
            

            projLabel.topAnchor.constraint(equalTo: compLabel.bottomAnchor),
            projLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            projLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            projLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

    @IBAction func completePressed(_ sender: UIButton) {
    }
    
    
    
    
    
    @IBAction func editPressed(_ sender: UIButton) {
    }
    
}
