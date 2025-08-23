//
//  TextFieldView.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 23/08/25.
//

import SwiftUI

struct TextFieldView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool = false
    var autocapital: UITextAutocapitalizationType = .sentences
    var textRules: ((String) -> String)?
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.autocorrectionType = .no
        textField.autocapitalizationType = autocapital
        textField.isSecureTextEntry = isSecure
        
        if isSecure {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            button.tintColor = .gray
            button.addTarget(context.coordinator, action: #selector(Coordinator.toggleSecure), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)

            textField.rightView = button
            textField.rightViewMode = .always
            context.coordinator.secureToggleButton = button
            context.coordinator.textField = textField
        }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldView
        weak var textField: UITextField?
        weak var secureToggleButton: UIButton?
        private var isSecureVisible = false
        
        init(_ parent: TextFieldView) {
            self.parent = parent
        }
        
        @objc func toggleSecure() {
            guard let tf = textField else { return }
            isSecureVisible.toggle()
            tf.isSecureTextEntry = !isSecureVisible
            secureToggleButton?.setImage(
                UIImage(systemName: isSecureVisible ? "eye" : "eye.slash"),
                for: .normal
            )
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let current = textField.text as NSString? {
                let updated = current.replacingCharacters(in: range, with: string)
                
                if let rule = parent.textRules {
                    let filtered = rule(updated)
                    DispatchQueue.main.async {
                        self.parent.text = filtered
                        textField.text = filtered
                    }
                    return false
                } else {
                    DispatchQueue.main.async {
                        self.parent.text = updated
                    }
                }
            }
            return true
        }
    }
}
