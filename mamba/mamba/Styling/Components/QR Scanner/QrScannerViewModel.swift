//
//  QrScannerViewModel.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/21.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import Foundation

class QrScannerViewModel: ObservableObject {
    let scanInterval: Double = 1.0
    
    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = ""
    
    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
    }
}
