//
//  PresentAnimation.swift
//  SegueTransition
//
//  Created by اسرارالحق  on 25/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

class PresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),  //ViewControllerOne
            let toVC = transitionContext.viewController(forKey: .to),   //ViewControllerTwo
            let snapshotView = toVC.view.snapshotView(afterScreenUpdates: true)
            else {return}
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        snapshotView.frame = originFrame
        snapshotView.layer.cornerRadius = 20
        snapshotView.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView)
        toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseOut,
                       animations: {
                        snapshotView.frame = finalFrame
                        snapshotView.layoutIfNeeded()
        }) { (finished) in
            toVC.view.isHidden = false
            snapshotView.removeFromSuperview()
            fromVC.view.layer.transform = CATransform3DIdentity
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
    
}
