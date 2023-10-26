//
//  SettingsRowView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 20/10/2023.
//

import SwiftUI

struct SettingsRowView: View {

    let imageName: String
    let title: String
    let tinColor: Color

    var body: some View {
        HStack(spacing: 12) {
          Image(systemName: imageName)
                .font(.title)
                .foregroundColor(tinColor)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)

        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(imageName: "gear", title: "Version", tinColor: Color(.systemGray))
    }
}
