//
//  Credentials.swift
//  mvvmPractice
//
//  Created by Felipe Gil on 2021-07-19.
//

import UIKit

struct User {
    var name: Observable<String>
}
class Observable<ObservedType> {
    private var _value: ObservedType
    var valueChanged: ((ObservedType?) -> ())?
    public var value: ObservedType? {
        get {
            return _value
        }
        set {
            guard let newValue = newValue else { return }
            _value = newValue
            valueChanged?(_value)
        }
    }
    
    func bindingChanged(to newValue: ObservedType) {
        _value = newValue
        print("Value is now \(newValue)")
    }
    
    init (_ value: ObservedType) {
        _value = value
    }
}

class BoundTextField: UITextField {
    var changedClosure: (() -> ())?
    @objc func valueChanged() {
        changedClosure?()
    }
    
    func bind(to observable: Observable<String>) {
        addTarget(self, action: #selector(BoundTextField.valueChanged), for: .editingChanged)
        
        changedClosure = { [weak self] in
            observable.bindingChanged(to: self?.text ?? "")
        }
        
        observable.valueChanged = { [weak self] newValue in self?.text = newValue}
    }
}
