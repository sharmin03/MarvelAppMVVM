//
//  ImageLoader.swift
//  Marvel
//
//  Created by Maximilian Fehrentz on 02.06.20.
//  Copyright © 2020 Maximilian Fehrentz. All rights reserved.
//

import Foundation
import UIKit

// i would want to make this an extension of UIIMage
class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
        
    init(imageUrl: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let fetchedImage = try UIImage(data: Data(contentsOf: URL(string: imageUrl)!))
                DispatchQueue.main.async {
                    self.image = fetchedImage
                }
            }
            catch(let error) {
                print("The image for the character could not be fetched.")
                print(error)
            }
        }
    }
}
