//
//  TableViewCell.swift
//  SegueTransition
//
//  Created by اسرارالحق  on 25/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentImageView.layer.cornerRadius = 30
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func animateContent() {
//        let imgView = UIImageView()
//        imgView.frame = CGRect(x: contentImageView.frame.origin.x,
//                          y: contentImageView.frame.origin.y,
//                          width: contentImageView.frame.size.width - 40,
//                          height: contentImageView.frame.size.height - 40)
//        imgView.center = self.contentView.center
//        UIView.animate(withDuration: 2.3) {
//
//            self.contentImageView.frame = imgView.frame
//        }
        let forword = CGAffineTransform(scaleX: 0.9, y: 0.9)
        let backword = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.5, animations: {
            self.contentImageView.transform = forword
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.contentImageView.transform = backword
            }
        }
    }
    
}
