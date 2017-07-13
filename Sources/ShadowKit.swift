//
//  ShadowKit.swift
//  ShadowKit
//
//  Created by Mayur on 03/04/17.
//  Copyright © 2017 Mayur. All rights reserved.
//

import UIKit

extension UIImage{
    
    public func applyShadowBlur(with radius: CGFloat = 80.0, queue: DispatchQueue = .global(qos: .utility), onCompletionExecute closure: @escaping (UIImage) -> Void) {
        applyBlurEffect(to: self, radius: radius, queue: queue) { (shadowBlurredImage) in
            closure(shadowBlurredImage)
        }
    }
    
}

public extension UIImageView {

//	public func blurBackground(onCompletionExecute closure: @escaping () -> Void) {
//		guard let image = self.image else {
//			fatalError("🚨 No image in the UIImageView")
//		}
//		applyBlurEffect(to: image) { (_) in
//			closure()
//		}
//	}
    
    public func generateBackgroundBlur(){
        guard let image = self.image else {
            fatalError("🚨 No image in the UIImageView")
        }
        applyBlurEffect(to: image) { (_) in
//            closure()
        }
    }
    
}

public func applyBlurEffect(to image: UIImage, radius: CGFloat = 80.0, queue: DispatchQueue = DispatchQueue.global(qos: .utility), completionHander: @escaping (UIImage) -> Void) {
    queue.async {
        
		let context = CIContext(options: nil)
		guard let imageToBlur = CIImage(image: image),
			let blurfilter = CIFilter(name: "CIGaussianBlur") else {
				fatalError("🚨 blur unsuccesful")
		}
        
		blurfilter.setValue(imageToBlur, forKey: "inputImage")
		let inset = CGFloat(radius * 4.0)
		blurfilter.setValue(radius, forKey: "inputRadius")
		let resultImage = blurfilter.value(forKey: "outputImage") as! CIImage
		
		//What we hope to achieve at the end point it to return an image with a blur. This image should be slightly larger across bounds of the imageview, which will them super-impose the image on top of the blur, giving it the Apple Music album art effect.
		//Figure out the extents of both the original and the blurred images:
		let origExtent = imageToBlur.extent
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
