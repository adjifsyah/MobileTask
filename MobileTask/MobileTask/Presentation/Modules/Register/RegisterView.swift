//
//  RegisterView.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel: RegisterViewModel = RegisterViewModel()
    @FocusState var focus
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    Text("Daftar")
                        .font(.largeTitle)
                    
                    if !viewModel.message.isEmpty && viewModel.success == false {
                        Text(viewModel.message)
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(.red)
                    }
                        
                    TextFieldView(text: $viewModel.name, placeholder: "Nama")
                        .modifier(FormStyle())
                        .focused($focus)
                    
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
                    
                    TextFieldView(text: $viewModel.confirmPassword, placeholder: "Konfirmasi Password", isSecure: true)
                        .modifier(FormStyle())
                        .focused($focus)
                    
                    Button("Daftar Sekarang") {
                        viewModel.register()
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                .padding(.top, 48)
                .padding(.horizontal)
            }
        }
        .alert("Berhasil", isPresented: $viewModel.success) {
            Button("OK") {
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Selamat, akun anda telah terdaftar.")
        }
        .onTapGesture {
            focus = false
        }
    }
}

#Preview {
    RegisterView()
}
