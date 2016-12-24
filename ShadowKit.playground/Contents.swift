//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import CoreImage

let sara = #imageLiteral(resourceName: "Screen Shot 2016-12-22 at 1.08.32 AM.png")

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
	blurfilter!.setValue(50.0, forKey: "inputRadius")
	let resultImage = blurfilter!.value(forKey: "outputImage") as! CIImage
	let cgImage = context.createCGImage(resultImage, from: (imageToBlur?.extent)!)
	let blurredImage = UIImage(cgImage: cgImage!)
	return blurredImage
	
}

class TestViewController: UIViewController {
	let imgView = UIImageView(image: sara)
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.white
		view.addSubview(imgView)
		imgView.frame = CGRect(x: 0, y: 0, width: 375, height: 375 * 809/1337)
		
		let newImage = UIImageView(frame: CGRect(x: 0, y: 250, width: 375 , height: 375 * 809/1337))
		
		newImage.image = applyBlurEffect(image: sara)
		view.addSubview(newImage)
	}
}

let test = TestViewController()
PlaygroundPage.current.liveView = UINavigationController(rootViewController: test)
