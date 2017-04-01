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
    let blurRadius = 90.0
    let inset = CGFloat(blurRadius * 4.0 + 0.0)
    blurfilter!.setValue(blurRadius, forKey: "inputRadius")
    let resultImage = blurfilter!.value(forKey: "outputImage") as! CIImage
    
    //What we hope to achieve at the end point it to return an image with a blur. This image should be slightly larger across bounds of the imageview, which will them super-impose the image on top of the blur, giving it the apple music album art effect
    
    //Figure out the extents of both the original and the blurred images:
    let origExtent = imageToBlur!.extent
    var newExtent = resultImage.extent
    
    //Normalise the bounds and center of the new extent to fit our requirement of 'slightly larger bounds than the original image'
    //First, we re-orient the center:
    newExtent.origin.x += (newExtent.size.width - origExtent.size.width - inset * 0.75)/2
    newExtent.origin.y += (newExtent.size.height - origExtent.size.height - inset * 0.75)/2
    //...and then re-size to fit:
    newExtent.size = CGSize(width: origExtent.size.width + inset * 0.75, height: origExtent.size.height + inset * 0.75)
    
    let cgImage = context.createCGImage(resultImage, from: newExtent)
    let blurredImage = UIImage(cgImage: cgImage!)
    return blurredImage
}

class TestViewController: UIViewController {
	let imgView = UIImageView(image: zankyoReference)
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.white
		view.addSubview(imgView)
		imgView.frame = CGRect(x: 40, y: 80, width: 295, height: 295)
        imgView.layer.cornerRadius = 8
        imgView.clipsToBounds = true
		
		let newImage = UIImageView(frame: CGRect(x: 0, y: 40, width: 375, height: 375))
		
		newImage.image = applyBlurEffect(image: zankyoReference)
		view.insertSubview(newImage, belowSubview: imgView)
		newImage.contentMode = .scaleAspectFit
		newImage.clipsToBounds = false
		
		
		let bgBlur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
		bgBlur.frame = CGRect(x: 0, y: 375, width: 375, height: 375)
		bgBlur.backgroundColor = .clear
		let bgImage = UIImageView(image: zankyoReference)
		bgImage.frame = bgBlur.frame
		view.addSubview(bgImage)
		view.addSubview(bgBlur)
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
