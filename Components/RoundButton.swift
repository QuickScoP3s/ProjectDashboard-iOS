//
//  RoundButton.swift
//  Components
//
//  Created by Waut Wyffels on 17/01/2020.
//  Copyright © 2020 Quick Development. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    private func setup() {
        setTitleColor(.lightText, for: .disabled)
        setTitleColor(.white, for: .normal)
        
        backgroundColor = .systemIndigo
    }
}
