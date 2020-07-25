//
//  ViewController.swift
//  SegueTransition
//
//  Created by اسرارالحق  on 25/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

class ViewControllerOne: UIViewController {

    @IBOutlet weak var imageVu: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageVu.image = #imageLiteral(resourceName: "ProfilePic")
    }

    @IBAction func goButton(_ sender: Any) {
        performSegue(withIdentifier: "ShowDetails", sender: self.imageVu)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewControllerTwo,
            let imgVu = sender as? UIImageView
            {
                vc.image = imgVu.image
                vc.transitioningDelegate = self
        } else {
            print("Fail")
        }
    }
    
}
//MARK: - SCALE DELEGATE
extension ViewControllerOne: Scaleable {
    var frame: CGRect {
        imageVu.frame
    }
}

//MARK: - TRANSITIONING DELEGATE

extension ViewControllerOne: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PresentAnimation(originFrame: imageVu.frame)
        
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation(destinationFrame: imageVu.frame)
    }
    
    
}




