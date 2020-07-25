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
    var cell: TableViewCell!
    var startFrame: CGRect = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func goButton(_ sender: Any) {
        performSegue(withIdentifier: "ShowDetails", sender: self.imageVu)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewControllerTwo,
            let imgVu = sender as? UIImageView
            {
                vc.image = imgVu.image
                vc.transitioningDelegate = self
        } else {
            print("Fail")
        }
    }
    
    
}

extension ViewControllerOne: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        self.imageVu = cell?.contentImageView
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        self.startFrame = cell.convert(cell.contentImageView.frame, to: nil)
        tableView.deselectRow(at: indexPath, animated: true)

        guard let vc = storyboard?.instantiateViewController(identifier: "ViewControllerTwo") as? ViewControllerTwo else {return}
        vc.image = self.imageVu.image
        performSegue(withIdentifier: "ShowDetails", sender: self.imageVu)
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




