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
    
    @IBAction func goButton(_ sender: Any) {
        performSegue(withIdentifier: "ShowDetails", sender: self.imageVu)
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
        cell?.titleLabel.text = " This is dummy title label for product being presented"
        self.imageVu = cell?.contentImageView
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        self.startFrame = cell.convert(cell.containerView.frame, to: nil)
        
//
//        guard let vc = storyboard?.instantiateViewController(identifier: "ViewControllerTwo") as? ViewControllerTwo else {return}
////        vc.image = contents[indexPath.row].image//cell.contentImageView.image
////        vc.text = contents[indexPath.row].description
////        print(contents[indexPath.row].description)
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowDetails", sender: indexPath.row)
    }
    
}


//MARK: - SCALE DELEGATE for segue
extension ViewControllerOne: Scaleable {
    var frame: CGRect {
        imageVu.frame
    }
}

//MARK: - TRANSITIONING DELEGATE

extension ViewControllerOne: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PresentAnimation(originFrame: startFrame)
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation(destinationFrame: startFrame)
    }
    
    
}



