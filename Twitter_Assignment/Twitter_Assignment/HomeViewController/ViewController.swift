//
//  ViewController.swift
//  Twitter_Assignment
//
//  Created by Diep Thien Lan on 4/24/19.
//  Copyright © 2019 Lan Thien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    
    var messages = [String]()
    let cellId = "SendMessageTableViewCell"
    lazy var emptyLabel:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "You're not post any message."
        label.sizeToFit()
        label.center = view.center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configUI()
    }
    
    func configUI() {
        tableView.register(UINib(nibName: cellId, bundle: nil),
                           forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
        view.insertSubview(emptyLabel, at: 0)
    }
    
    @IBAction func tapOnCreateMessageButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let sendMessageVC = storyBoard.instantiateViewController(withIdentifier: "SendMessageViewController") as? SendMessageViewController
            else { return }
        sendMessageVC.delegate = self
        self.navigationController?.pushViewController(sendMessageVC, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SendMessageTableViewCell
        cell.setMessageContent(message: messages[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}

extension ViewController: SendMessageDelegate {
    func sendMessages(messages: [String]) {
        self.messages.append(contentsOf: messages)
        tableView.reloadData()
        
        emptyLabel.isHidden = self.messages.count > 0
    }
}
