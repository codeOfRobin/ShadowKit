//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import CoreImage

let sara = #imageLiteral(resourceName: "Sara-Bareilles-Whats-Inside-Songs-From-Waitress.png")
let takingOff = #imageLiteral(resourceName: "ONE-OK-ROCK-Taking-Off-2016-Cover.jpg")
let zankyoReference = #imageLiteral(resourceName: "cover.jpg")
let downtownFiction = #imageLiteral(resourceName: "ib524565.jpg")

func applyBlurEffect(image: UIImage) -> UIImage {
	let context = CIContext(options: nil)
	let imageToBlur = CIImage(image: image)
	let blurfilter = CIFilter(name: "CIGaussianBlur")
	blurfilter!.setValue(imageToBlur, forKey: "inputImage")
	let blurRadius = 40.0
	let inset = CGFloat(blurRadius * 4.0 + 10.0)
	blurfilter!.setValue(blurRadius, forKey: "inputRadius")
	let resultImage = blurfilter!.value(forKey: "outputImage") as! CIImage
	
	let origExtent = imageToBlur!.extent
	var newExtent = resultImage.extent
	newExtent.origin.x += (newExtent.size.width - origExtent.size.width - inset)/2
	newExtent.origin.y += (newExtent.size.height - origExtent.size.height - inset)/2
	newExtent.size = CGSize(width: origExtent.size.width + inset, height: origExtent.size.height + inset)
	
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
		newImage.contentMode = .scaleAspectFit
		newImage.clipsToBounds = false
		
		imgView.alpha = 0
	}
}


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


let test = TestViewController()
PlaygroundPage.current.liveView = UINavigationController(rootViewController: test)
