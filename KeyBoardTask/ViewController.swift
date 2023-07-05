//
//  ViewController.swift
//  KeyBoardTask
//  Created by Sindhu Bachu on 27/06/23.

//
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        dismissFunc()
        
           
       }
   func dismissFunc(){
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          view.addGestureRecognizer(tapGesture)
       
       textField.delegate = self
   }
      

@objc func dismissKeyboard() {
    view.endEditing(true)
}

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }



}

//        let keyPadView = NumericKeyBoardView(frame: CGRect(x: 0, y: 0, width: 0,  height:(view.frame.height) * 1 / 2))
//        keyPadView.delegate = self
//
//
//        textField.inputView = keyPadView
//    }
//        func dismissFunc(){
//
//                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//
