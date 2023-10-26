//
//  HomeView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 20/10/2023.
//

import SwiftUI

struct HomeView: View {

    @State private var path = NavigationPath() // <--- here

    var body: some View {
        NavigationStack(path: $path) { // <--- here
              VStack(alignment: .center) {
                 // Image("login")
                  Image(systemName: "house")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .cornerRadius(10)
                      .padding()

                  Text("Hello !")
                      .font(.title)
                      .bold()
                  Text("Please select the Option")
                      .bold()
                  Button {
                      path.append("LoginView") // <--- here
                      print("Login button was tapped")
                  } label: {
                      Text("Login")
                          .padding()
                          .foregroundStyle(.white)
                          .frame(height: 60)
                          .frame(maxWidth: .infinity)
                          .background(.blue)
                  }

                  Button {
                      path.append("Registration")  // <--- here
                      print("Registration button was tapped")
                  } label: {
                      Text("Registration")
                          .padding()
                          .foregroundStyle(.white)
                          .frame(height: 60)
                          .frame(maxWidth: .infinity)
                          .background(.blue)
                  }
              }
              // --- here
              .navigationDestination(for: String.self) { destination in
                  if destination == "LoginView" {
                      LoginView()
                  } else {
                      RegistrationView()
                  }
              }
              // --- here
              .toolbar {
                  ToolbarItem(placement: .navigationBarLeading) {
                      HStack {
                          Circle()
                              .fill(.blue)
                              .frame(width: 40, height: 40)
                          Text("SLOP")
                              .font(.system(size: 20))
                              .fontWeight(.medium)
                      }
                      .padding(.leading, 20)
                  }
              }
          }
      }
  }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
