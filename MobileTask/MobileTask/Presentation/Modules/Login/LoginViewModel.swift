//
//  LoginViewModel.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import SwiftUI
import RxSwift

class LoginViewModel: ObservableObject {
    @Published var user: UserModel? = nil
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var message: String = ""
    
    private let repository = Injection.shared.provideLoginRepository()
    private let disposeBag = DisposeBag()
}

extension LoginViewModel {
    func login() {
        message = ""
        user = nil
        guard !username.isEmpty, !password.isEmpty else {
            message = "Semua field wajib diisi"
            return
        }
        
        repository.execute(request: UserModel(name: "", username: username, password: password))
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.user = data
                self?.message = "Login berhasil"
            }, onError: { [weak self] error in
                self?.message = error.localizedDescription
            })
            .disposed(by: disposeBag)
    }
}
