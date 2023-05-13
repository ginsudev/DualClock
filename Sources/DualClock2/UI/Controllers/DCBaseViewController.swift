//
//  DCBaseViewController.swift
//  
//
//  Created by Noah Little on 7/5/2023.
//

import UIKit
import GSCore

final class DCBaseViewController: UIViewController {
    private let hostingController = LSPresentableHostingController(rootView: ContentView())
    private let globalState = GlobalState.shared
    
    override func _canShowWhileLocked() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = nil
        hostingController.view.backgroundColor = nil
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupConstrains()
    }
    
    func setupConstrains() {
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hostingController.view.updateConstraints()
    }
}
