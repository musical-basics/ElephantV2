//
//  ItemCell.swift
//  ElephantV2
//
//  Created by Lionel Yu on 12/11/22.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var projLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        sendSubviewToBack(contentView)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: projLabel.topAnchor),

//            compLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
//            compLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//            compLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
//            compLabel.bottomAnchor.constraint(equalTo: projLabel.topAnchor),

            projLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            projLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            projLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            projLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        titleLabel?.numberOfLines = 0;
        titleLabel?.lineBreakMode = .byWordWrapping;
        projLabel?.numberOfLines = 0;
        projLabel?.lineBreakMode = .byWordWrapping;
        

        
        
    }
    
    @IBAction func compPressed(_ sender: UIButton) {
        print("hi")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        //init subviews, eg. self.switch = UISwitch()
//        super.init(style: style, reuseIdentifier: "ReusableCell")
//
//        // add this line magic code
//        contentView.isUserInteractionEnabled = true
//
//        //add subviews, e.g. self.addSubView(self.switch)
//    }
    
 
    
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        // 1) Set the contentView's width to the specified size parameter
//        contentView.pin.width(size.width)
//
//        // 2) Layout the contentView's controls
//        layout()
//
//        // 3) Returns a size that contains all controls
//        return CGSize(width: contentView.frame.width, height: adsViewsCount.frame.maxY + padding)
//    }

    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        // The UITableView will call the cell's sizeThatFit() method to compute the height.
//        // WANRING: You must also set the UITableView.estimatedRowHeight for this to work.
//        return UITableView.automaticDimension
//    }
    
}

//extension UITableViewCell {
//    open override func addSubview(_ view: UIView) {
//        super.addSubview(view)
//        sendSubviewToBack(contentView)
//    }
//}


