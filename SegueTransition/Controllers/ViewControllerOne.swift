//
//  ViewController.swift
//  SegueTransition
//
//  Created by اسرارالحق  on 25/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

class ViewControllerOne: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var imageVu: UIImageView!
    var cell = CustomTableViewCell()
    var startFrame: CGRect = CGRect.zero
    var contents = Content.all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewControllerTwo,
            let index = sender as? Int
        {
            vc.index = index
            vc.transitioningDelegate = self
        } else {
            print("Fail")
        }
    }
    
    
}

extension ViewControllerOne: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
        cell?.contentImageView.image = contents[indexPath.row].image
        cell?.smallImageView.image = contents[indexPath.row].image
        cell?.titleLabel.text = " This is dummy title label for product being presented in showcase"
        self.imageVu = cell?.contentImageView
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        self.startFrame = cell.convert(cell.containerView.frame, to: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowDetails", sender: indexPath.row)
    }
    
}

//MARK: - TRANSITIONING DELEGATE

extension ViewControllerOne: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation(originFrame: startFrame, duration: 0.8, initialVelocity: 0.001, damping: 0.7)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation(destinationFrame: startFrame, duration: 0.5, initialVelocity: 0.0001, damping: 0.8)
    }
}



