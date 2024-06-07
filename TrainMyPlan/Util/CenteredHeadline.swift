//
//  CenteredHeadline.swift
//  TrainMyPlan
//
//  Created by Marlon Klaus on 07.06.24.
//

import SwiftUI

struct CenteredHeadline: View {
    var content: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(content)
            Spacer()
        }
    }
}
