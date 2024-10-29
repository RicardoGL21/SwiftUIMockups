//
//  PurchasePlanSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 18/10/24.
//

import SwiftUI

struct PurchasePlanSwiftUI: View {
    var body: some View {
        VStack {
            
            VStack {
                Text("PLAN IDOLO")
                    .font(.system(size: 30, weight: .bold))
                HStack(spacing:0) {
                    Text("15GB")
                    Text("/mes")
                }
                .font(.system(size: 25,weight: .bold))
                Text("Número: 555555555")
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .padding()
            
            Text("Elige tu forma de pago")
                .font(.system(size: 16))
            
            PaymentMethodSwiftUI(mercadoPago: true, paypal: true, applepay: true, openpay: true)
            
            Spacer()
        }
    }
}

struct PaymentMethodSwiftUI: View {
    
    @State var isLoadingMP: Bool = false
    @State var isLoadingPaypal: Bool = false
    @State var isLoadingApplePay: Bool = false
    @State var isLoadingOpenPay: Bool = false
    
    var mercadoPago:Bool
    var paypal:Bool
    var applepay:Bool
    var openpay:Bool
    
    var body: some View {
        VStack{
            
            if mercadoPago {
                Button {
                    isLoadingMP.toggle()
                } label: {
                    HStack {
                        Image(.paypalMethod)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100)
                            .frame(height: 20)
                        Spacer()
                        Rectangle()
                            .frame(width: 1)
                        Spacer()
                        Text("Tarjeta de crédito/débito")
                            .font(.system(size: 11.0))
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Spacer()
                    }
                }
                .buttonStyle(LoadingButtonStyle(isLoading: $isLoadingMP))
            }

            if paypal {
                Button {
                    isLoadingPaypal.toggle()
                } label: {
                    HStack {
                        Image(.paypalMethod)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100)
                            .frame(height: 20)
                        Spacer()
                        Rectangle()
                            .frame(width: 1)
                        Spacer()
                        Text("PayPal")
                            .font(.system(size: 11.0))
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Spacer()
                    }
                }
                .buttonStyle(LoadingButtonStyle(isLoading: $isLoadingPaypal))
            }
            
            if applepay {
                Button {
                    isLoadingApplePay.toggle()
                } label: {
                    HStack {
                        Image(.paypalMethod)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100)
                            .frame(height: 20)
                        Spacer()
                        Rectangle()
                            .frame(width: 1)
                        Spacer()
                        Text("Apple Pay")
                            .font(.system(size: 11.0))
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Spacer()
                    }
                }
                .buttonStyle(LoadingButtonStyle(isLoading: $isLoadingApplePay))
            }
            
            if openpay {
                Button {
                    isLoadingOpenPay.toggle()
                } label: {
                    HStack {
                        Image(.paypalMethod)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 100)
                            .frame(height: 20)
                        Spacer()
                        Rectangle()
                            .frame(width: 1)
                        Spacer()
                        Text("Tienda física")
                            .font(.system(size: 11.0))
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Spacer()
                    }
                }
                .buttonStyle(LoadingButtonStyle(isLoading: $isLoadingOpenPay))
            }
            
        }
    }
}

#Preview {
    PurchasePlanSwiftUI()
}

struct LoadingButtonStyle: ButtonStyle {
    @Binding var isLoading: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            if isLoading {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .frame(width: 20, height: 20)
                Spacer()
            } else {
                configuration.label
            }
            
        }
        .padding()
        .frame(width: 300, height: 60)
        .background(.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
        .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
        .animation(.easeInOut(duration: 0.3), value: isLoading)
    }
}
