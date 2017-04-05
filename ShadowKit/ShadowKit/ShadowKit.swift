//
//  ShadowKit.swift
//  ShadowKit
//
//  Created by Mayur on 03/04/17.
//  Copyright © 2017 Mayur. All rights reserved.
//

import UIKit

public struct ShadowKitTemp{
    
    //Hah! Remember Java?
    public static let sharedTemp = ShadowKitTemp()
    
    public func applyBlurEffect(image: UIImage, completionHander: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            let context = CIContext(options: nil)
            let imageToBlur = CIImage(image: image)
            let blurfilter = CIFilter(name: "CIGaussianBlur")
            blurfilter!.setValue(imageToBlur, forKey: "inputImage")
            let blurRadius = 90.0
            let inset = CGFloat(blurRadius * 4.0 + 0.0)
            blurfilter!.setValue(blurRadius, forKey: "inputRadius")
            let resultImage = blurfilter!.value(forKey: "outputImage") as! CIImage
            
            //What we hope to achieve at the end point it to return an image with a blur. This image should be slightly larger across bounds of the imageview, which will them super-impose the image on top of the blur, giving it the Apple Music album art effect.
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
            
            DispatchQueue.main.async {
                completionHander(blurredImage)
            }
        }
    }
}
