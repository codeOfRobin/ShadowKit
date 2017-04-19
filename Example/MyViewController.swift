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

let saraImage = #imageLiteral(resourceName: "sara")

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


class MyViewController: UIViewController {
	let imgView = UIImageView(image: saraImage)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.white
		view.addSubview(imgView)
		imgView.frame = CGRect(x: 40, y: 80, width: 295, height: 295)
		imgView.layer.cornerRadius = 8
		imgView.clipsToBounds = true
		
		let newImageView = UIImageView(frame: CGRect(x: 10, y: 60, width: 355, height: 355))
		
        saraImage.applyingShadowBlur({ (blurredImage) in
            UIView.animate(withDuration: 0.47, animations: {
                self.imgView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                newImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: {(completed) in
                //FIXME: Chaining animations this way is terrible. Use keyframe animations instead.
                newImageView.image = blurredImage
                self.view.insertSubview(newImageView, belowSubview: self.imgView)
                newImageView.alpha = 0.4
                UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                    newImageView.layer.cornerRadius = 20
                    newImageView.alpha = 1.0
                    newImageView.transform = .identity
                    self.imgView.transform = .identity
                    
                }, completion: nil)
            })
        })
	}
}

