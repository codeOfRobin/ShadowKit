//
//  ShadowKit.swift
//  ShadowKit
//
//  Created by Robin Malhotra on {TODAY}.
//  Copyright © 2017 ShadowKit. All rights reserved.
//


import UIKit

extension UIImage{
	
	/// Call this method on a UIImage to its shadow blurred image called in a completion handler.
	/// The completion handler will be called asynchronously on the main thread.
	///
	/// - Parameter completionHandler: A callback recieved with the shadowblurred image as a parameter
	public func applyingShadowBlur(_ completionHandler: @escaping (UIImage) -> Void) {
		applyBlurEffect(to: self) { (shadowBlurredImage) in
			completionHandler(shadowBlurredImage)
		}
	}
}

extension UIImageView{
	public func applyingShadowBlueToImage(_ completionHandler: @escaping (UIImage?) -> Void) {
		guard let image = self.image else { completionHandler(nil); return }
		
		applyBlurEffect(to: image) { (shadowBlurredImage) in
			completionHandler(shadowBlurredImage)
		}
	}
}

//TODO: Have an extension on UIImageView that automatically populates the blurred image behind the current image and returns. (Maybe ask for an animation?)

//TODO: Have an extension on a UIView that takes a 'screenshot' of the current view and returns a blurred image of that view (asynchronously)

func applyBlurEffect(to image: UIImage, completionHander: @escaping (UIImage) -> Void) {
	DispatchQueue.global(qos: .userInteractive).async {
		let context = CIContext(options: nil)
		let imageToBlur = CIImage(image: image)
		let blurfilter = CIFilter(name: "CIGaussianBlur")
		blurfilter!.setValue(imageToBlur, forKey: "inputImage")
		let blurRadius = 80.0
		let inset = CGFloat(blurRadius * 4.0)
		blurfilter!.setValue(blurRadius, forKey: "inputRadius")
		let resultImage = blurfilter!.value(forKey: "outputImage") as! CIImage
		
		//What we hope to achieve at the end point it to return an image with a blur. This image should be slightly larger across bounds of the imageview, which will them super-impose the image on top of the blur, giving it the Apple Music album art effect.
		//Figure out the extents of both the original and the blurred images:
		let origExtent = imageToBlur!.extent
		var newExtent = resultImage.extent
		
		//Normalise the bounds and center of the new extent to fit our requirement of 'slightly larger bounds than the original image'
		//First, we re-orient the center:
		let reorientationFraction = CGFloat(1.0)
		newExtent.origin.x += (newExtent.size.width - origExtent.size.width - inset * reorientationFraction)/2
		newExtent.origin.y += (newExtent.size.height - origExtent.size.height - inset * reorientationFraction)/2
		//...and then re-size to fit:
		newExtent.size = CGSize(width: origExtent.size.width + inset * reorientationFraction, height: origExtent.size.height + inset * reorientationFraction)
		
		let cgImage = context.createCGImage(resultImage, from: newExtent)
		let blurredImage = UIImage(cgImage: cgImage!)
		
		//FIXME: Don't assume the queue to be main, here. Instead, conserve whatever queue that the implementor made the call from
		DispatchQueue.main.sync {
			completionHander(blurredImage)
		}
	}
}
