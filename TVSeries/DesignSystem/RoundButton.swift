//
//  RoundButton.swift
//  Boxifarma
//
//  Created by Bruno Scheltzke on 04/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

@IBDesignable
class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        let titleSize: CGFloat = 18
        titleLabel?.font = .systemFont(ofSize: titleSize)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setup()
    }
    
    override var intrinsicContentSize: CGSize {
        let height: CGFloat = 45
        var width: CGFloat = 80
        let padding: CGFloat = 110
        
        if let font = self.titleLabel?.font,
            let calculatedWidth = titleLabel?.text?.width(withConstrainedHeight: height, font: font),
            calculatedWidth != 0 {
            width = calculatedWidth + padding
        }
        return CGSize(width: width, height: height)
    }
    
}

@IBDesignable
class RoundButton: BaseButton {
    
    override func setup() {
        super.setup()
        cornerRadius = 20
        tintColor = .white
        backgroundColor = .secondaryColor
    }
    
}

@IBDesignable
class PrimaryRoundButton: RoundButton {
    
    override func setup() {
        super.setup()
        backgroundColor = .black
    }
    
}

@IBDesignable
class SecondaryRoundButton: RoundButton {
    
    override func setup() {
        super.setup()
        backgroundColor = .secondaryColor
    }
    
}
