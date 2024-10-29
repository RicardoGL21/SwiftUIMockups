//
//  PurchaseEsimSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 30/08/24.
//

import SwiftUI

struct PurchaseEsimSwiftUI: View {
    
    @State var showIHaveACode = false
    @State var txtIHaveCode = ""
    @State var acceptDeviceEsim = false
    @State var acceptTermsAndConditions = false
    @State var selectedCard: Int? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Realiza tu compra")
                    .font(.system(size: 20.0,weight: .bold))
                
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                    VStack {
                        Text("Producto")
                            .font(.system(size: 16.0,weight: .bold))
                        Text("eSIM\nVicengia 1 dia")
                            .font(.system(size: 16.0))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    VStack {
                        Text("Cantidad")
                            .font(.system(size: 16.0,weight: .bold))
                        Text("1")
                            .font(.system(size: 16.0))
                        Spacer()
                    }
                    VStack {
                        Text("Total")
                            .font(.system(size: 16.0,weight: .bold))
                        Text("$80.00")
                            .font(.system(size: 16.0))
                        Spacer()
                    }
                })
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black,lineWidth: 3)
                }
                .padding()
                
                HStack {
                    Text("Tengo un código")
                        .font(.system(size: 16.0))
                        .underline()
                        .onTapGesture {
                            withAnimation {
                                showIHaveACode.toggle()
                            }
                            
                        }
                    Image(systemName: "questionmark.circle")
                        .onTapGesture {
                            withAnimation {
                                showIHaveACode.toggle()
                            }
                        }
                    Spacer()
                }
                .padding(.horizontal,20)
                
                if showIHaveACode {
                    TextField("Ingresa tu código", text: $txtIHaveCode)
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray.opacity(0.5), lineWidth: 2)
                        )
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .padding(.horizontal, 15)
                }
                
                HStack {
                    Toggle(isOn: $acceptDeviceEsim, label: {
                    })
                    .labelsHidden()
                    Spacer()
                    Text("Al completar la solicitud, confirmas que cuentas con un dispositivo compatible con eSIM.")
                        .font(.system(size: 14.0))
                        .onTapGesture {
                            acceptDeviceEsim.toggle()
                        }
                    Spacer()
                }
                .padding()
                
                HStack {
                    Toggle(isOn: $acceptTermsAndConditions, label: {
                    })
                    .labelsHidden()
                    Spacer()
                    Text("Aceptas Términos y Condiciones y el Aviso de Privacidad")
                        .font(.system(size: 14.0))
                        .onTapGesture {
                            acceptTermsAndConditions.toggle()
                        }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                VStack {
                    Text("Selecciona tu método de pago")
                        .font(.system(size: 16.0,weight: .bold))
                        .frame(maxWidth: .infinity)
                    
                    Text("Tarjetas disponibles")
                        .padding(.top)
                    
                                    
                    List(0...3,id: \.self) { index in
                        ItemCreditCardRow(lastNumbers: "1234", isSelected: self.selectedCard == index)
                            .listRowSeparator(.hidden)
                            .listRowSpacing(0)
                            .listRowInsets(EdgeInsets())
                            .padding(.horizontal,10)
                            .padding(.bottom,10)
                            .onTapGesture {
                                if self.selectedCard == index {
                                    self.selectedCard = nil
                                } else {
                                    self.selectedCard = index
                                }
                            }
                    }
                    .listStyle(.inset)
                    .frame(height: 130)
                    
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Image(systemName: "creditcard")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            Text("Agregar tarjeta de crédito o débito")
                                .font(.callout)
                            Spacer()
                        }
                        .frame(width: 300)
                    })
                    .buttonStyle(MyCustomButtonUI())
                    
                    Button(action: {
                        
                    }, label: {
                        HStack {
                            Image(.paypalWhite)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            Text("Pagar con PayPal")
                                .font(.callout)
                            Spacer()
                        }
                        .frame(width: 300)
                    })
                    .buttonStyle(MyCustomButtonUI())
                    
                }
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black,lineWidth: 3)
                        .padding(.horizontal)
                }
                
                if let indexCard = self.selectedCard, acceptDeviceEsim && acceptTermsAndConditions {
                    Button(action: {
                        
                    }, label: {
                        Text("Pagar")
                            .padding(.horizontal)
                    })
                    .buttonStyle(MyCustomButtonAccentUI())
                    .padding(.top)
                }
                
                
                Spacer()
            }
        }
    }
}

struct ItemCreditCardRow :View {
    
    var lastNumbers:String
    var isSelected:Bool
    
    var body: some View {
        HStack {
            Image(isSelected ? .radioOn : .radioOff)
                .resizable()
                .scaledToFit()
                .frame(width: 20)
            Spacer()
            Text("XXXX XXXX XXXX \(lastNumbers)")
        }
        .padding()
        .background(Color(.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 15.0))
    }
}

#Preview {
    PurchaseEsimSwiftUI()
}
