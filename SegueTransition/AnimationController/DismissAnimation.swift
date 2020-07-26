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
            let snapshotView = toVC.cell.contentImageView.snapshotView(afterScreenUpdates: false)  // snapShotView is taget view in which sending view will transform
            else {
                return
        }
        
        snapshotView.layer.cornerRadius = 30
        snapshotView.frame = fromVC.imagevu.frame
        snapshotView.layer.masksToBounds = true
        
        // 2
        let containerView = transitionContext.containerView
        containerView.addSubview(snapshotView)
        fromVC.view.isHidden = true
        toVC.cell.contentImageView.isHidden = true
        
        
        // 3
        let duration = transitionDuration(using: transitionContext)
        
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
            toVC.cell.contentImageView.isHidden = false
            snapshotView.removeFromSuperview()
            if transitionContext.transitionWasCancelled {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}






