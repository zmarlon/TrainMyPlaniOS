//
//  FloatNumberTextInputField.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 08.06.24.
//

import SwiftUI

struct FloatNumberTextInputField: View {
    var preview: String
    @Binding var input: String
    
    var body: some View {
        TextField(preview, text: $input)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: input, { oldValue, newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        let count = newValue.filter { $0 == "." }.count

                        if filtered != newValue && count < 2  {
                            input = filtered
                        }
                    })
    }
}

