//
//  MarginLabel.swift
//  Plister
//
//  Created by Mohammad reza Koohkan on 8/10/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit

final class MarginLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
}
