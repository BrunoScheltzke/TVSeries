//
//  UIColor.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 04/06/20.
//

import UIKit

extension UIColor {
    static let primaryColor = #colorLiteral(red: 0.9335942268, green: 0.4552852511, blue: 0.232208252, alpha: 1)
    static let secondaryColor = #colorLiteral(red: 0.1493424773, green: 0.4151260257, blue: 0.5608921051, alpha: 1)
    static let terciaryColor = #colorLiteral(red: 0.9500272633, green: 0.9500272633, blue: 0.9500272633, alpha: 1)
    static let primaryTextColor = #colorLiteral(red: 0.1234618798, green: 0.3293651342, blue: 0.4030899704, alpha: 1)
    static let secondaryTextColor = #colorLiteral(red: 0.2970306114, green: 0.2970306114, blue: 0.2970306114, alpha: 1)
    
    func toImage(of size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width, height: size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
