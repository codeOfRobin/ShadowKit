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


func applyBlurEffect(image: UIImage) -> UIImage {
	let context = CIContext(options: nil)
	let imageToBlur = CIImage(image: image)
	let blurfilter = CIFilter(name: "CIGaussianBlur")
	blurfilter!.setValue(imageToBlur, forKey: "inputImage")
	blurfilter!.setValue(75.0, forKey: "inputRadius")
	let resultImage = blurfilter!.value(forKey: "outputImage") as! CIImage
	
	let origExtent = imageToBlur!.extent
	print(origExtent)
	//	let newExtent = CGRect(origin: .zero, size: resultImage.extent.size).insetBy(dx: 300, dy: 300)
	let newExtent = origExtent.insetBy(dx: -157, dy: -157)
	print(newExtent)
	let cgImage = context.createCGImage(resultImage, from: newExtent)
	let blurredImage = UIImage(cgImage: cgImage!)
	return blurredImage
	
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
		
		newImage.image = applyBlurEffect(image: sara)
		view.insertSubview(newImage, belowSubview: imgView)
		newImage.layer.cornerRadius = 10	
		//		imgView.alpha = 0
	}
}

