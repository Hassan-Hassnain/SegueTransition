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
    private let initialVelocity: CGFloat
    private let springDamping: CGFloat
    private let animationDuration:Double
    
    init(originFrame: CGRect, duration: Double, initialVelocity: CGFloat, damping: CGFloat) {
        self.originFrame = originFrame
        self.animationDuration = duration
        self.initialVelocity = initialVelocity
        self.springDamping = damping
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ViewControllerOne,  //ViewControllerOne
            let toVC = transitionContext.viewController(forKey: .to) as? ViewControllerTwo,   //ViewControllerTwo
            let snapshotView = toVC.view.snapshotView(afterScreenUpdates: true)
            else {return}
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        snapshotView.frame = originFrame
        snapshotView.layer.cornerRadius = 20
        snapshotView.layer.masksToBounds = true
        
        fromVC.cell.showAnimation {  //This animation will push the table view cell
            containerView.addSubview(toVC.view)
            containerView.addSubview(snapshotView)
            toVC.view.isHidden = true
            
            let duration = self.transitionDuration(using: transitionContext)
            
            UIView.animate(withDuration: duration,   ///this animation will perform during transition to ViewControllerTwo
                delay: 0.0,
                usingSpringWithDamping: self.springDamping,
                initialSpringVelocity: self.initialVelocity,
                options: .curveEaseInOut,
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
    
    
    
}
