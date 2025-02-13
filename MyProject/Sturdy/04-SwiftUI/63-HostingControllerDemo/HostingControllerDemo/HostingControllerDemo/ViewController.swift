//
//  ViewController.swift
//  HostingControllerDemo
//
//  Created by Jungman Bae on 1/23/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let swiftUIViewController = UIHostingController(rootView: SwiftUIView())
        addChild(swiftUIViewController)
        swiftUIViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(swiftUIViewController.view)
        
        swiftUIViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiftUIViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        swiftUIViewController.didMove(toParent: self)
    }

    @IBSegueAction func showSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView())
    }
    
    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView())
    }
}

