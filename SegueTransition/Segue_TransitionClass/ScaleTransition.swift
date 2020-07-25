//
//  ScaleTransition.swift
//  SegueTransition
//
//  Created by اسرارالحق  on 25/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//
//

import UIKit

protocol Scaleable {
    var frame: CGRect { get }
}

class ScaleTransition: UIStoryboardSegue {
    
    override func perform() {
        destination.transitioningDelegate = self
        super.perform()
    }
}

extension ScaleTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return TransitionPresenter()
    }
}

class TransitionPresenter: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = (transitionContext.viewController(forKey: .to))!
        let toView = transitionContext.view(forKey: .to)
        
        if let this = toView {
            transitionContext.containerView.addSubview(this)
        }
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let fromView = transitionContext.view(forKey: .from )
        
        var startFrame = CGRect.zero
        if let fromViewController = fromViewController as? Scaleable {
            startFrame = fromViewController.frame //fromViewController.imageFrame.frame
            print("Frame assigned   \(fromViewController.frame)")
        }
        else{
            print("Error")
        }
        
        toView?.frame  = startFrame
        toView?.layoutIfNeeded()
        
        let duration = transitionDuration(using: transitionContext)
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        //        UIView.animate(withDuration: duration, animations: {
        //
        //            toView?.frame = finalFrame
        //            toView?.layoutIfNeeded()
        //
        //        }) { (finished) in
        //            transitionContext.completeTransition(true)
        //        }
        
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.2,
                       options: .curveEaseOut,
                       animations: {
                        toView?.frame = finalFrame
                        toView?.layoutIfNeeded()
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
        
    }
}

