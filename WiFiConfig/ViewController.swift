//
//  ViewController.swift
//  WiFiConfig
//
//  Created by Patrick Maltagliati on 1/5/18.
//  Copyright © 2018 Patrick Maltagliati. All rights reserved.
//

import UIKit
import NetworkExtension

class ViewController: UIViewController {
    
    @IBOutlet weak var ssidTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ssidTextField?.delegate = self
        passwordTextField?.delegate = self
    }
    
    @IBAction func configureButtonTapped() {
        guard let ssid = ssidTextField?.text, let password = passwordTextField?.text else {
            print("SSID or password missing")
            return
        }
        if #available(iOS 11.0, *) {
            let configuration = NEHotspotConfiguration(ssid: ssid, passphrase: password, isWEP: false)
            NEHotspotConfigurationManager.shared.apply(configuration) { (error) in
                if let error = error {
                    print(error)
                } else {
                    print("Successfully joined the network")
                }
            }
        } else {
            print("WiFi Config only allowed on iOS 11")
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

