//
//  MBProgressHUDWrapper.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import SwiftUI
import MBProgressHUD

struct MBProgressHUDWrapper: UIViewRepresentable {
    @Binding var isShowing: Bool
    var text: String?

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
//        guard let window = uiView.window else { return }
        
        if isShowing {
            let hud = MBProgressHUD.showAdded(to: uiView, animated: true)
            hud.mode = .indeterminate
            hud.label.text = text
        } else {
            MBProgressHUD.hide(for: uiView, animated: true)
        }
    }
}
