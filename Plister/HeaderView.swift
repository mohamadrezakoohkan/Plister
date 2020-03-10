//
//  HeaderView.swift
//  Plister
//
//  Created by Mohammad reza Koohkan on 9/3/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
final class HeaderView: UIView {
    
    var target: (SubmitButton) -> Void
    
    lazy var form: FormStackView = {
        .init(onSubmit: self.target,orderedInputs: [
            (key: "key", placeHolder:"unique key"),
            (key: "value", placeHolder: "value for key")
        ])
    }()
    
    init(frame: CGRect, target: @escaping (SubmitButton) -> Void) {
        self.target = target
        super.init(frame: frame)
        self.backgroundColor = .white
        self.form.addTo(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

