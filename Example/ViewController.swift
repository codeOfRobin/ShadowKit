//
//  ViewController.swift
//  Example
//
//  Created by Robin Malhotra on 13/07/17.
//  Copyright © 2017 ShadowKit. All rights reserved.
//
import UIKit
import ShadowKit

class ViewController: UIViewController {

    @IBOutlet var albumView: UIImageView!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
		// Do any additional setup after loading the view, typically from a nib.
	}
    
    func blurImage() {
//        albumView.blurBackground(onCompletionExecute: {
//            
//        })
        
        
        albumView.generateBackgroundBlur()
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

    @IBAction func blurTapped(_ sender: AnyObject) {
        blurImage()
    }

}

