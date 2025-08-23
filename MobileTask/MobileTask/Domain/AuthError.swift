//
//  AuthError.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import Foundation

enum AuthError: Error {
    case usernameTaken
    case userNotFound
    case wrongPassword
    case wrongUsername
    case unknownRequest
    case notImpelemented
    case unknown
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .usernameTaken:
            return "Username sudah digunakan"
        case .userNotFound:
            return "User tidak ditemukan"
        case .wrongUsername, .wrongPassword:
            return "Username atau Password salah"
        case .unknownRequest:
            return "Terjadi kesalahan request"
        case .notImpelemented:
            return "Fitur belum di implementasikan"
        case .unknown:
            return "Terjadi kesalahan"
        }
    }
}
