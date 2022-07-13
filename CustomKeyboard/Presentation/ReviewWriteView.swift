//
//  ReviewWriteView.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/13.
//

import UIKit

class ReviewWriteView: UIViewController {
    private let textView = UITextView()
    private let customKeyboard = CustomKeyBoard()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute() {
        self.title = " 리뷰 작성 "
        view.backgroundColor = .white
        textView.font = .systemFont(ofSize: 20)
    }
    
    private func layout() {
        [textView, customKeyboard].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        customKeyboard.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        customKeyboard.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        customKeyboard.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        customKeyboard.heightAnchor.constraint(equalToConstant: CustomKeyBoard.Math.width*3/4).isActive = true
        
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.bottomAnchor.constraint(equalTo: customKeyboard.topAnchor).isActive = true
    }
}
