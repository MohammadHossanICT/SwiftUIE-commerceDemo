//
//  ContentViewOne.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 20/10/2023.
//

import SwiftUI

struct ContentViewOne: View {

    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentViewOne_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewOne()
    }
}
