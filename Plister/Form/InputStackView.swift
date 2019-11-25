//
//  InputStackView.swift
//  Plister
//
//  Created by Mohammad reza Koohkan on 8/10/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
final class InputView: UIView {
    
    var title: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text = newValue }
    }
    
    var text: String? {
        get { return self.textField.text }
        set { self.textField.text = newValue }
    }
    
    private (set) var placeHolder: String? {
        get { return self.textField.placeholder }
        set { self.textField.placeholder = newValue }
    }
    
    private (set) lazy var titleLabel: MarginLabel = {
        let label = MarginLabel()
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        return label
    }()
    
    private (set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name:"HelveticaNeue", size: 17.0)
        return textField
    }()
    
    private (set) lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.insertArrangedSubview(self.textField, at: 0)
        stackView.insertArrangedSubview(self.titleLabel, at: 0)
        self.titleLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return stackView
    }()
    
    init(frame: CGRect = .zero,
         title: String,
         text: String? = nil,
         placeHolder: String) {
        
        super.init(frame: frame)
        
        self.title = title
        self.text = text
        self.placeHolder = placeHolder
        
        self.setup()
        self.insert()
    }
    
    func clean() {
        self.text = nil
    }
    
    private func setup() {
        self.layer.cornerRadius = 5
//        self.layer.borderColor = #colorLiteral(red: 0.9532980323, green: 0.9534575343, blue: 0.9532770514, alpha: 1).cgColor
//        self.layer.borderWidth = 1
    }
    
    private func insert() {
        self.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.fillSuperView()
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIView {
    
    func fillSuperView() {
        guard let parent = self.superview else { fatalError("There is no superView") }
        guard #available(iOS 9.0, *) else { return }
        let constraints = [topAnchor.constraint(equalTo: parent.topAnchor),
                           bottomAnchor.constraint(equalTo: parent.bottomAnchor),
                           leadingAnchor.constraint(equalTo: parent.leadingAnchor),
                           trailingAnchor.constraint(equalTo: parent.trailingAnchor)]
        constraints.forEach {  $0.isActive = true  }
        
    }
}
