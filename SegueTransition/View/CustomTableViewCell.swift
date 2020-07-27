//
//  CustomTableViewCell.swift
//  SegueTransition
//
//  Created by اسرارالحق  on 27/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

typealias Closure = () -> Void

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var smallImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var closure: Closure? = nil
    
      override func awakeFromNib() {
          super.awakeFromNib()
          containerView.layer.cornerRadius = 30
        containerView.clipsToBounds = true
        button.layer.cornerRadius = button.frame.size.height/2
        smallImageView.layer.cornerRadius = 15
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.layer.borderWidth = 1.0
      }
      
      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          
      }
    func configure(content: Content) {
        self.smallImageView.image = content.image
        self.contentImageView.image = content.image
        self.titleLabel.text = " This is dummy title label for product being presented"
    }
    
    
}
