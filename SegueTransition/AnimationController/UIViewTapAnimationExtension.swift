//
//  UIViewTapAnimationExtension.swift
//  SegueTransition
//
//  Created by اسرارالحق  on 26/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .beginFromCurrentState,
                       animations: { [weak self] in
                        self?.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
                        
        }){ _ in
        self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            completionBlock()
//            UIView.animate(withDuration: 0.0,
//                           delay: 0,
//                           options: .curveLinear,
//                           animations: { [weak self] in
//                            self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
//            })
        }
    }
    
    func showTapAnimation(_ completionBlock: @escaping () -> Void) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                        self?.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            }
        ) {  (done) in
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
    
}
