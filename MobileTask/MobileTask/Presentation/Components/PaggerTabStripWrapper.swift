//
//  PaggerTabStripWrapper.swift
//  MobileTask
//
//  Created by Adji Firmansyah on 22/08/25.
//

import SwiftUI
import XLPagerTabStrip

class SwiftUIChildController<Content: View>: UIHostingController<Content>, IndicatorInfoProvider {

    private let titlePage: String

    init(title: String, rootView: Content) {
        self.titlePage = title
        super.init(rootView: rootView)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: titlePage)
    }
}

class SwiftUIPagerTabStripController: ButtonBarPagerTabStripViewController {

    private let childVCs: [UIViewController]

    init(childVCs: [UIViewController]) {
        self.childVCs = childVCs
        super.init(nibName: nil, bundle: nil)
        
        settings.style.selectedBarHeight = 3
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 16)
        
        settings.style.buttonBarBackgroundColor = UIColor(Color.yellow.opacity(0.3))
        settings.style.selectedBarBackgroundColor = UIColor(Color.red.opacity(0.5))
        settings.style.buttonBarItemBackgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return childVCs
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        changeCurrentIndexProgressive = { oldCell, newCell, progress, change, animated in
            guard change else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = UIColor(Color.red.opacity(0.8))
        }
    }
}

struct PagerTabStripWrapper: UIViewControllerRepresentable {
    var childViewControllers: [UIViewController]

    func makeUIViewController(context: Context) -> SwiftUIPagerTabStripController {
        SwiftUIPagerTabStripController(childVCs: childViewControllers)
    }

    func updateUIViewController(_ uiViewController: SwiftUIPagerTabStripController, context: Context) { }
}
