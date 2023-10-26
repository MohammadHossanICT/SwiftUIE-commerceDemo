//
//  AuthViewModel.swift
//  DemoEcommerce
//
//  Created by M A Hossan on 20/10/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formValid: Bool { get }
}

protocol AuthViewModelProtocol {

    func signIn(withEmail email: String, password: String) async throws
    func createUser(withEmail email: String, password: String, fullname: String) async throws
    func signOut() async
    func fetchUser() async
}

@MainActor
class AuthViewModel: AuthViewModelProtocol, ObservableObject {

    @Published var userSession: Firebase.User?
    @Published var currentUser: User?
    @Published var isErrorOccured = false
    @Published private(set) var customError: NetworkError?

    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }

    func signIn(withEmail email: String, password: String) async throws {

        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession  = result.user
            await fetchUser()
            isErrorOccured = false

        } catch {
            print("Falie to sign in \(error.localizedDescription)")
            isErrorOccured = true

        }
    }

    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodeUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodeUser)
            await fetchUser()

        } catch {
            print("Error failed to create user\(error.localizedDescription)")
        }
    }

    func signOut() async {

        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Faile to sign out \(error.localizedDescription)")
        }
    }

    func fetchUser() async {

        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return}
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
