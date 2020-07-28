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
    private let initialVelocity: CGFloat
    private let springDamping: CGFloat
    private let animationDuration:Double
    
    init(destinationFrame: CGRect, duration: Double, initialVelocity: CGFloat, damping: CGFloat) {
        self.destinationFrame = destinationFrame
        self.animationDuration = duration
        self.initialVelocity = initialVelocity
        self.springDamping = damping
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ViewControllerTwo,
            let toVC = transitionContext.viewController(forKey: .to) as? ViewControllerOne,
            let snapshotView = toVC.cell.snapshotView(afterScreenUpdates: true)  // snapShotView is taget view in which sending view will transform
            else {
                return
        }
        
        snapshotView.frame = fromVC.view.frame// fromVC.startFrame
        print(snapshotView.frame)
        snapshotView.layer.cornerRadius = 30
        snapshotView.layer.masksToBounds = true
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView)
        fromVC.view.isHidden = true
        toVC.cell.isHidden = true
        toVC.view.isHidden = false
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: self.springDamping,
                       initialSpringVelocity: self.initialVelocity,
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
    }
    
    
}








