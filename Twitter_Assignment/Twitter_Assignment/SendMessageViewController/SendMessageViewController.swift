//
//  SendMessageViewController.swift
//  Twitter_Assignment
//
//  Created by Diep Thien Lan on 4/25/19.
//  Copyright © 2019 Lan Thien. All rights reserved.
//

import UIKit

protocol SendMessageDelegate:class {
    func sendMessages(messages:[String])
}

class SendMessageViewController: UIViewController {
    
    @IBOutlet weak var tvMessage:UITextView!
    @IBOutlet weak var cstBottomMessage:NSLayoutConstraint!
    var notEdited = true
    weak var delegate:SendMessageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(observeKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        configUI()
    }
    
    func configUI() {
        tvMessage.becomeFirstResponder()
        tvMessage.delegate = self
        
        moveCursorToFirstText()
    }
    
   
    
    @objc func observeKeyboard(_ noti:Notification)  {
        guard let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        if self.view.frame.origin.y == 0{
            cstBottomMessage.constant = keyboardSize.height
            view.layoutIfNeeded()
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if tvMessage.text.count > 0 {
            do {
                let messages = try Utilities.splitMessage(tvMessage.text)
                if let delegate = delegate {
                    delegate.sendMessages(messages: messages)
                }
                navigationController?.popViewController(animated: true)
            }
            catch SplitMessageError.NotHaveSpaceCharactor {
                presentAlert(title: "Warning", message: "Your message have a word more than 50 characters.")
            }
            catch {
                
            }
        }
        else {
            presentAlert(title: "Warning", message: "Your message is empty.")
        }
    }
    
    private func presentAlert(title:String?, message:String?) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func moveCursorToFirstText() {
        let newPosition = tvMessage.beginningOfDocument
        tvMessage.selectedTextRange = tvMessage.textRange(from: newPosition, to: newPosition)
    }
}

extension SendMessageViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let size = textView.contentSize
        let frame = textView.frame
        if (size.height > frame.height) {
            textView.contentOffset.y = size.height - frame.height
        }
        else {
            textView.contentOffset.y = 0
        }
        UIView.animate(withDuration: 0.2) {[weak self] in
            self?.view.layoutIfNeeded()
        }
        return true
    }
}
