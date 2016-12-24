//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import CoreImage

let sara = #imageLiteral(resourceName: "Sara-Bareilles-Whats-Inside-Songs-From-Waitress.png")

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
	blurfilter!.setValue(100.0, forKey: "inputRadius")
	let resultImage = blurfilter!.value(forKey: "outputImage") as! CIImage
	
	let origExtent = imageToBlur?.extent
	print(resultImage.extent)
//	let newExtent = CGRect(origin: .zero, size: resultImage.extent.size).insetBy(dx: 300, dy: 300)
	let newExtent = resultImage.extent.insetBy(dx: 525, dy: 525)
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
		
		let newImage = UIImageView(frame: CGRect(x: 10, y: 50, width: 355 , height: 355))
		
		newImage.image = applyBlurEffect(image: sara)
		view.insertSubview(newImage, belowSubview: imgView)
		newImage.clipsToBounds = false
		
//		imgView.alpha = 0
	}
}

let test = TestViewController()
PlaygroundPage.current.liveView = UINavigationController(rootViewController: test)
