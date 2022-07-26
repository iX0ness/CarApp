//
//  UIImage+Extension.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 26/07/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func rotate360(_ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.transform = CGAffineTransform.init(rotationAngle: .pi)
            UIView.animate(withDuration: 0.5) {
                self?.transform = CGAffineTransform.init(rotationAngle: 2 * .pi)
                completion?()
            }
        }
    }
    
    func moveRight(_ value: CGFloat, withDuration: TimeInterval, delay: CGFloat) {
        UIView.animate(withDuration: withDuration, delay: delay) { [weak self] in
            self?.frame.origin.x += value / 2
        }
    }
}
