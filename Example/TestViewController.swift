//
//  ViewController.swift
//  Example
//
//  Created by Robin Malhotra on 25/12/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

//: Playground - noun: a place where people can play

import UIKit
import CoreImage
import ShadowKit

let sara = #imageLiteral(resourceName: "sara")

enum ShadowInput {
	case view(view: UIView)
	case image(image: UIImage)
}

func shadowMaker(input: ShadowInput) -> UIImage {
	switch input {
	case .view(view: let view):
		return UIImage()
	case .image(image: let image):
		print(image)
		return image
	}
}


class TestViewController: UIViewController {
	let imgView = UIImageView(image: sara)
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.white
		view.addSubview(imgView)
		imgView.frame = CGRect(x: 40, y: 80, width: 295, height: 295)
		imgView.layer.cornerRadius = 8
		imgView.clipsToBounds = true
		
		let newImage = UIImageView(frame: CGRect(x: 10, y: 60, width: 355, height: 355))
		
        ShadowKitTemp.sharedTemp.applyBlurEffect(image: sara, completionHander: {(blurredImage) in
            UIView.animate(withDuration: 0.47, animations: {
                self.imgView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                newImage.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: {(completed) in
                //FIXME: Chaining animations this way is terrible. Use keyframe animations instead.
                newImage.image = blurredImage
                self.view.insertSubview(newImage, belowSubview: self.imgView)
                newImage.alpha = 0.4
                UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                    newImage.layer.cornerRadius = 20
                    newImage.alpha = 1.0
                    newImage.transform = .identity
                    self.imgView.transform = .identity
                    
                }, completion: nil)
            })
        })
	}
}

