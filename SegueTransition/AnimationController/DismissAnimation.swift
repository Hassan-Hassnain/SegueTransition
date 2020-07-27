//
//  DismissAnimation.swift
//  SegueTransition
//
//  Created by اسرارالحق  on 25/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

class DismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let destinationFrame: CGRect
    
    init(destinationFrame: CGRect) {
        self.destinationFrame = destinationFrame
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ViewControllerTwo,
            let toVC = transitionContext.viewController(forKey: .to) as? ViewControllerOne,
            let snapshotView = toVC.cell.snapshotView(afterScreenUpdates: true)  // snapShotView is taget view in which sending view will transform
            else {
                return
        }
        
        snapshotView.frame = fromVC.startFrame
        print(snapshotView.frame)
        snapshotView.layer.cornerRadius = 30
        snapshotView.layer.masksToBounds = true
        
        // 2
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView)
        fromVC.view.isHidden = true
        toVC.cell.isHidden = true
        toVC.view.isHidden = false
        
        
        // 3
        let duration = transitionDuration(using: transitionContext)
        
//        UIView.animate(withDuration: 1.0, animations: {
//            fromVC.cell.frame = toVC.cell.frame
//
//        }) { (true) in
             UIView.animate(withDuration: duration,
                                  delay: 0.0,
                                  usingSpringWithDamping: springDamping,
                                  initialSpringVelocity: initialVelocity,
                                  options: .curveEaseOut,
                                  animations: {
                                    snapshotView.frame = self.destinationFrame
                                   snapshotView.layoutIfNeeded()
                   }) { _ in
                       fromVC.view.isHidden = false
                       toVC.cell.isHidden = false
                       snapshotView.removeFromSuperview()
                       if transitionContext.transitionWasCancelled {
                           toVC.view.removeFromSuperview()
                       }
                       transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                   }
//        }
    }
    
}






