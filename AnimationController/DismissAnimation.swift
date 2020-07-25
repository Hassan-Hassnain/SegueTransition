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
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ViewControllerTwo,
            let toVC = transitionContext.viewController(forKey: .to) as? ViewControllerOne,
            let snapshotView = toVC.imageVu.snapshotView(afterScreenUpdates: false)  // snapShotView is taget view in which sending view will transform
            else {
                return
        }
        
        snapshotView.layer.cornerRadius = 0
        snapshotView.layer.masksToBounds = true
        
        // 2
        let containerView = transitionContext.containerView
        //      containerView.insertSubview(toVC.view, at: 0)
        containerView.addSubview(snapshotView)
        fromVC.view.isHidden = true
        
        // 3
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseOut,
                       animations: {
                        snapshotView.frame = self.destinationFrame
                        snapshotView.layoutIfNeeded()
        }) { _ in
            fromVC.view.isHidden = false
            snapshotView.removeFromSuperview()
            if transitionContext.transitionWasCancelled {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
    }
    
    
    
}
