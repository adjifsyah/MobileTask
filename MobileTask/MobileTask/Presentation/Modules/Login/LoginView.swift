//
//  LoginView.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    var onLoginSuccess: (UserModel) -> Void
    @FocusState var focus
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    Text("Masuk")
                        .font(.largeTitle)
                    
                    if !viewModel.message.isEmpty && viewModel.user == nil {
                        Text(viewModel.message)
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(.red)
                    }
                    
                    TextFieldView(text: $viewModel.username, placeholder: "Username", textRules: { input in
                        input.lowercased()
                            .replacingOccurrences(of: " ", with: "")
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                    })
                    .modifier(FormStyle())
                    .focused($focus)
                    
                    TextFieldView(text: $viewModel.password, placeholder: "Password", isSecure: true)
                        .modifier(FormStyle())
                        .focused($focus)
                    
                    Button("Login") {
                        viewModel.login()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    HStack(spacing: 2) {
                        Text("Belum memiliki akun?")
                            .font(.system(size: 12))
                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Daftar Sekarang")
                                .font(.system(size: 12))
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .padding(.top, 48)
                .padding(.horizontal)
            }
        }
        .onChange(of: (viewModel.user?.name ?? "")) { oldValue, newValue in
            if let user = viewModel.user {
                onLoginSuccess(user)
            }
        }
        .onTapGesture {
            focus = false
        }
    }
}

struct FormStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .background(RoundedRectangle(cornerRadius: 4).stroke(.gray))
    }
}
#Preview {
    LoginView(onLoginSuccess: { _ in })
}
