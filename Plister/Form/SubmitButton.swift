//
//  SubmitButton.swift
//  Plister
//
//  Created by Mohammad reza Koohkan on 8/10/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit

class SubmitButton: UIButton {
    
    init(target: Any?,action: Selector) {
        super.init(frame: .zero)
        
        self.setup()
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
   private func setup(){
    self.setTitle("Create", for: .normal)
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = #colorLiteral(red: 0.3612798452, green: 0.7261628509, blue: 0.1558039784, alpha: 1)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tappedIn(pressure: CGFloat = 0.985, duration: TimeInterval = 0.1) {
        self.superview?.endEditing(true)
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform.init(scaleX: pressure, y: pressure)
        },completion:{
            if $0 {
                UIView.animate(withDuration: duration, animations: {
                    self.transform = .identity
                })
            }
        })
        
    }
    
}
