//
//  RegisterViewModel.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation
import RxSwift

final class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var message: String = ""
    
    @Published var success: Bool = false
    
    private let repository = Injection.shared.provideRegisterRepository()
    private let disposeBag = DisposeBag()
    
    func register() {
        message = ""
        
        guard !name.isEmpty, !username.isEmpty, !password.isEmpty else {
            message = "Semua field wajib diisi"
            success = false
            return
        }
        guard password == confirmPassword else {
            message = "Password tidak cocok"
            success = false
            return
        }
        
        let user = UserModel(name: name, username: username, password: password)
        
        repository.execute(request: user)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] result in
                    if result {
                        self?.message = "Registrasi berhasil"
                        self?.success = true
                    } else {
                        self?.message = "Registrasi gagal"
                        self?.success = false
                    }
                },
                onError: { [weak self] error in
                    self?.message = error.localizedDescription
                    self?.success = false
                }
            )
            .disposed(by: disposeBag)
    }

}
