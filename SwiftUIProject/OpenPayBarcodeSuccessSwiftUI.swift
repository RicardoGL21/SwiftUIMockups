//
//  OpenPayBarcodeSuccessSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 24/10/24.
//

import SwiftUI

struct OpenPayBarcodeSuccessSwiftUI: View {
    var body: some View {
        VStack {
            Text("¡Tu ficha digital está lista!")
                .font(.system(size: 18, weight: .bold))
                .padding(.top)
            Text("Muestra este código desde tu celular en la tienda de tu preferencia.")
                .multilineTextAlignment(.center)
                .padding(.top,5)
                .padding(.horizontal)
                .font(.system(size: 15))
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                Image(.iconPaynet)
                    .resizable()
                    .scaledToFit()
                Image(.iconOpenpay)
                    .resizable()
                    .scaledToFit()
            }
            .padding(.horizontal,40)
            
            Image(.iconPaynet)
                .resizable()
                .scaledToFit()
                .padding(.horizontal,40)
            
            Text("123414124213123")
                .font(.system(size: 15))
            
            Text("Monto a pagar")
                .font(.system(size: 18, weight: .bold))
                .padding(.top,5)
            
            Text("$350.00 MXN")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.vuela)
            
            Text("Referencia")
                .font(.system(size: 18, weight: .bold))
                .padding(.top,5)
            
            Text("Muestra este código desde tu celular en la tienda de tu preferencia.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom)
                .font(.system(size: 15))
                .fixedSize(horizontal: false, vertical: true)
            
        }
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black,lineWidth: 0.5)
            }
            .padding()
            .padding(.horizontal,20)
    }
}

#Preview {
    OpenPayBarcodeSuccessSwiftUI()
}
