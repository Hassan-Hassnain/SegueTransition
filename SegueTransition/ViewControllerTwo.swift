//
//  ViewControllerTwo.swift
//  SegueTransition
//
//  Created by اسرارالحق  on 25/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

class ViewControllerTwo: UIViewController {

    @IBOutlet weak var imagevu: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagevu.image = image
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
   

}
