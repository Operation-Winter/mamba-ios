//
//  IntegerTextField.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/07/31.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct IntegerTextField: View {
    private var formatter = NumberFormatter()
    @ObservedObject private var viewModel: IntegerTextFieldViewModel
    private var number: Binding<Int?>
    private var placeholder: String
    private var characterLimit: Int
    
    init(_ placeholder: String, number: Binding<Int?>, characterLimit: Int) {
        self.placeholder = placeholder
        self.number = number
        self.characterLimit = characterLimit 
        viewModel = IntegerTextFieldViewModel(number: number.wrappedValue)
    }
    
    internal var body: some View {
        let proxyNumber = Binding<String>(
            get: {
                if let number = self.viewModel.number {
                    return String(number)
                }
                return ""
            },
            set: {
                let filtered = $0.filter({ "0123456789".contains($0) })
                let filteredLimited = String(filtered.prefix(self.characterLimit))
                if let value = NumberFormatter().number(from: filteredLimited) {
                    self.viewModel.number = value.intValue
                    self.number.wrappedValue = value.intValue
                } else {
                    self.viewModel.number = nil
                    self.number.wrappedValue = nil
                }
            }
        )
        // TODO: Convert to UIKit UITextField to allow for Keyboard firstResponder
        return TextField(placeholder, text: proxyNumber)
            .keyboardType(.numberPad)
    }
}

class IntegerTextFieldViewModel: ObservableObject {
    @Published var number: Int?
    
    init(number: Int?) {
        self.number = number
    }
}

struct IntegerTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IntegerTextField("Test", number: .constant(0), characterLimit: 1)
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light mode")
            IntegerTextField("Test", number: .constant(0), characterLimit: 1)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark mode")
                .background(Color.black)
        }.previewLayout(.sizeThatFits)
    }
}
