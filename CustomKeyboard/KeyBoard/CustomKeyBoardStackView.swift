//
//  CustomKeyBoard.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/12.
//

import UIKit

final class CustomKeyBoardStackView: UIStackView {
    
    enum Math {
        static let keyboardWidth: CGFloat = UIScreen.main.bounds.width
        static let keyboardHeight: CGFloat = keyboardWidth < 340 ? keyboardWidth*3/5 : keyboardWidth*3/4
        static let buttonPadding = 5.0
        static let buttonWidth = keyboardWidth / 10.0 - buttonPadding
        static let fontSize: CGFloat = keyboardWidth < 340 ? 13.0 : 19.0
    }
    
    // MARK: - Properties
    private let firstLineContainer = FirstRowKeyContainerStackView()
    private let secondLineContainer = SecondRowKeyContainerStackView()
    private let thirdLineContainer = ThirdRowKeyContainerStackView()
    private let firthLineContainer = FirthRowKeyContainerStackView()
    
    weak var delegate: CustomKeyBoardStackViewDelegate?
    private let viewModel = CustomKeyBoardStackViewViewModel(engine: KeyBoardEngine())
    
    init() {
        super.init(frame: CGRect.zero)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - CustomKeyBoardStackView: private 메서드
extension CustomKeyBoardStackView {
    private func tappedBasicKey(unicode: Int) {
        
        delegate?.connectTextView().text = viewModel.addWord(inputUniCode: unicode, to: delegate?.connectTextView().text)
    }
}

//MARK: - FirstRowKeyContainerDelegate(첫번째줄컨테이너) 이벤트 메서드
extension CustomKeyBoardStackView: FirstRowKeyContainerStackViewDelegate {
    func tappedFirstrowBasicKey(unicode: Int) {
        
        tappedBasicKey(unicode: unicode)
    }
}

//MARK: - SecondRowKeyContainerDelegate(두번째줄컨테이너) 이벤트 메서드
extension CustomKeyBoardStackView: SecondRowKeyContainerStackViewDelegate {
    func tappedSecondrowBasicKey(unicode: Int) {
        
        tappedBasicKey(unicode: unicode)
    }
}

//MARK: - ThirdRowKeyContainerDelegate(세번째줄컨테이너) 이벤트 메서드
extension CustomKeyBoardStackView: ThirdRowKeyContainerStackViewDelegate {
    func tappedShiftButton() -> Bool {
        return firstLineContainer.toggleDynamicBasicKeyState() == .double ? true : false
    }
    
    func tappedBackButton() {
        
        delegate?.connectTextView().text = viewModel.removeWord(from: delegate?.connectTextView().text)
    }
    
    func tappedThirdrowBasicKey(unicode: Int) {
        
        tappedBasicKey(unicode: unicode)
    }
}

//MARK: - FirthRowKeyContainerDelegate(네번째줄컨테이너) 이벤트 메서드
extension CustomKeyBoardStackView: FirthRowKeyContainerStackViewDelegate {
    func tappedReturnButton() {
        
        delegate?.tappedReturnButton()
    }
    
    func tappedSpaceButton(_ inputUniCode: Int) {
        
        delegate?.connectTextView().text = viewModel.addSpace(inputUniCode: inputUniCode, to: delegate?.connectTextView().text)
    }
}

//MARK: - ConfigureUI
extension CustomKeyBoardStackView {
    private func configureUI() {
        
        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        
        backgroundColor = .systemGray3
        axis = .vertical
        distribution = .equalSpacing
        alignment = .center
        
        firstLineContainer.delegate = self
        secondLineContainer.delegate = self
        thirdLineContainer.delegate = self
        firthLineContainer.delegate = self
    }
    
    private func configureLayout() {
        
        let topPaddingView = UIView()
        let bottomPaddingView = UIView()
        
        [topPaddingView, firstLineContainer, secondLineContainer, thirdLineContainer, firthLineContainer, bottomPaddingView].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        topPaddingView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0).isActive = true
        bottomPaddingView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/8).isActive = true
        [firstLineContainer, secondLineContainer, thirdLineContainer, firthLineContainer].forEach {
            $0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/6).isActive = true
        }
        
        let sidePadding = Math.buttonPadding
        [firstLineContainer, secondLineContainer, thirdLineContainer, firthLineContainer].forEach {
            $0.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -sidePadding*2).isActive = true
        }
    }
}
