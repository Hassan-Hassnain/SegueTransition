//
//  ViewControllerTwo.swift
//  SegueTransition
//
//  Created by اسرارالحق  on 25/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

class ViewControllerTwo: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    var cell = CustomTableViewCell()
    var contents = Content.all
    var index: Int = 1
    var startFrame: CGRect = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        self.startFrame = containerView.frame
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func closeButton() {
            self.dismiss(animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
            cell.configure(content: contents[index])
            self.cell = cell
            updateView(cell)
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as! DescriptionCell
        cell.descriptionLabel.text = contents[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    fileprivate func updateView(_ cell: CustomTableViewCell?) {
        let receivedView = (cell?.containerView)!
        receivedView.layer.cornerRadius = 0
        self.containerView.addSubview(receivedView)
        receivedView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 0).isActive = true
        receivedView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 0).isActive = true
        receivedView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: 0).isActive = true
        receivedView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 0).isActive = true
        
        
        let button:UIButton = UIButton(frame: CGRect(x: 355, y: 15, width: 50, height: 50))
        button.setImage(#imageLiteral(resourceName: "download-1"), for: .normal)
        button.addTarget(self, action: #selector(closeButton), for: .touchUpInside)
        button.tag = 22;
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        
        self.containerView.addSubview(button)
    }
    
    
    
}
