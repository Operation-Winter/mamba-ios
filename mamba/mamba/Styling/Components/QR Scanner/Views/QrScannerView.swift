//
//  QrScannerView.swift
//  mamba
//
//  Created by Armand Kamffer on 2020/08/21.
//  Copyright © 2020 Armand Kamffer. All rights reserved.
//

import SwiftUI

struct QrScannerView: View {
    @ObservedObject var viewModel = QrScannerViewModel()
    var onQrFound: (String) -> Void
    
    var body: some View {
        ZStack {
            QrCodeScannerView()
                .found(completion: self.onQrFound)
                .torchLight(isOn: self.viewModel.torchIsOn)
                .interval(delay: self.viewModel.scanInterval)
            
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        self.viewModel.torchIsOn.toggle()
                    }, label: {
                        Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.blue)
                            .padding()
                    })
                }
                .background(Color.white)
                .cornerRadius(10)
                
            }.padding()
        }
    }
}

struct QrScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QrScannerView(onQrFound: {_ in})
    }
}
