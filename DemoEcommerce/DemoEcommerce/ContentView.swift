//
//  ContentView.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 19/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
         VStack(alignment: .center) {
             Image("login")
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
                 print("Login button was tapped")
             } label: {
                 Text("Login")
                     .padding()
                     .foregroundStyle(.white)
                     .frame(height: 60)
                     .frame(maxWidth: .infinity)
                     .background(.blue) // after setting the max width
             }

             Button {
                 print("Registration button was tapped")
             } label: {
                 Text("Registration")
                     .padding()
                     .foregroundStyle(.white)
                     .background(.blue)
                     .frame(height: 60)
                      .frame(maxWidth: .infinity)
                      .background(.blue) // after setting the max width
             }
         }
         .padding()
         .frame(maxHeight: .infinity)
         .overlay(alignment: .topLeading) {
             HStack {
                 Circle()
                     .fill(.blue)
                     .frame(width: 50, height: 60)

                 Text("SLOP")
                     .font(.system(size: 20))
                     .fontWeight(.medium)

             }
             .padding(.leading, 20)
         }
     }
 }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
