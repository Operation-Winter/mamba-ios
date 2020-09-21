//
//  ShareSheet.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/09/21.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
}
