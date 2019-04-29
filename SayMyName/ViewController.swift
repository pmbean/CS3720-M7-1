//
//  ViewController.swift
//  SayMyName
//
//  Created by Patrick Bean on 4/28/19.
//  Copyright © 2019 TheDevBean. All rights reserved.
//

import UIKit
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var forenameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    
    @IBAction func getContact(_ sender: AnyObject) {
        let contactStore = CNContactStore()
        contactStore.requestAccess(for: .contacts) {
            (success: Bool, error: Error?) -> Void in
            DispatchQueue.main.async {
                if (success) {
                    self.showPeoplePicker()
                }
            }
        }
    }
    
    @IBAction func sayContact(_ sender: Any) {
        if let firstName = forenameField.text, let lastName = surnameField.text {
            let personName = "You have chosen \(firstName) \(lastName)"
            TextToSpeech.SayText(input: personName)
        }
        
        
    }
    
    func showPeoplePicker() {
        let picker: CNContactPickerViewController = CNContactPickerViewController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        forenameField.text? = contact.givenName
        surnameField.text? = contact.familyName
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancelled")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

