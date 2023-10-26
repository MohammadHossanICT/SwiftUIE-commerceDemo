//
//  LoginView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 19/10/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {

        NavigationStack {

            VStack {
                // Login Image
                Image("signin")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)

                // form filed
                VStack(spacing: 24) {
                    InputView(text: $username, title: "username", placeholder: "name@gmail.com")
                        .autocapitalization(.none)
                    InputView(text: $password, title: "password", placeholder: "enter your password", isSecureField: true)

                }
                .padding(.horizontal)
                .padding(.top, 15)

                // creating sign in button

                Button {

                    Task {
                        try await viewModel.signIn(withEmail: username, password: password)
                    }

                } label: {
                    HStack {
                        Text("Sign In")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32 , height: 40)

                }
                .background(Color(.systemBlue))
                .disabled(!formValid)
                .opacity(formValid ? 1.0: 0.5)
                .cornerRadius(10)
                .padding(.top ,24)

                Spacer()

                // sign up button

                NavigationLink {
                    RegistrationView()
                    // Hiding the navigation back button hidden .
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Dont have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
            .alert(isPresented: $viewModel.isErrorOccured) {
                Alert(title: Text("Incorrect Username or password"), message: Text(viewModel.customError?.localizedDescription ?? ""),dismissButton: .default(Text("Okay")))
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {

    var formValid: Bool {
        return !username.isEmpty
        && username.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
