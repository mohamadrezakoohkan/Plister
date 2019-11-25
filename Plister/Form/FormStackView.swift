//
//  FormStackView.swift
//  Plister
//
//  Created by Mohammad reza Koohkan on 8/10/1398 AP.
//  Copyright © 1398 AP Apple Code. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
final class FormStackView: UIStackView {
    
    var inputs: [InputView] = []
    
    let height: CGFloat = 140
    let padding: CGFloat = 15
    
    var action: (SubmitButton) -> Void

    
    init(onSubmit: @escaping (SubmitButton) -> Void,
         orderedInputs: [(key: String,placeHolder: String)]) {
        self.action = onSubmit

        super.init(frame: .zero)

        self.fill(orderedInputs)
        self.setup()
        self.insert()
    }
    
    private func fill(_ list: [(key: String,placeHolder: String)]) {
        self.inputs = list.map { InputView(title: $0.key, placeHolder: $0.placeHolder) }
    }
    
    private func setup() {
        self.axis = .vertical
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 10
    }
    
    private func insert() {
        self.insertSubmit()
        self.inputs.reversed().forEach {
            self.insertArrangedSubview($0, at: 0)
        }
    }
    
    private func insertSubmit() {
        let submitBtn = SubmitButton(target: self, action: #selector(self.submitted(_:)))
        self.insertArrangedSubview(submitBtn, at: 0)
    }
    
    @objc func submitted(_ sender: SubmitButton) {
        sender.tappedIn()
        self.action(sender)
    }

    
    func addTo(_ view: UIView) {
        view.addSubview(self)
        let width = UIScreen.main.bounds.width - padding*2
        self.frame = CGRect(x: padding, y: padding,  width: width, height: self.height)
    }
    
    func clean() {
        self.inputs.forEach { $0.clean() }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
