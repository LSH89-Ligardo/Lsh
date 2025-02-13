//
//  MyScrollView.swift
//  UIViewDemo
//
//  Created by Jungman Bae on 1/23/25.
//

import SwiftUI

struct MyScrollView: UIViewRepresentable {
    var text: String
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var control: MyScrollView
        
        init(_ control: MyScrollView) {
            self.control = control
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            print("View is Scrolling")
        }
        
        @objc func handleRefresh(sender: UIRefreshControl) {
            sender.endRefreshing()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        
        scrollView.refreshControl = UIRefreshControl()
        
        scrollView.refreshControl?.addTarget(context.coordinator,
                                             action: #selector(Coordinator.handleRefresh),
                                             for: .valueChanged)
        
        let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        myLabel.text = text
        scrollView.addSubview(myLabel)
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
}


#Preview {
    MyScrollView(text: "Hello World")
}
