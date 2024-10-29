//
//  CustomDialog.swift
//  CursoiOS
//
//  Created by Ricardo Garcia on 11/06/24.
//

import SwiftUI

struct CustomDialog: View {
    
    @State private var showDetailEsim = false
    
    var body: some View {
        VStack {
            if showDetailEsim {
                DetailEsimPurchased(show: $showDetailEsim)
            } else {
                Text("Tus eSIM")
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        
                        ItemEsimPurchased(estatus: "Aprobada")
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    showDetailEsim.toggle()
                                }
                            }
                        ItemEsimPurchased(estatus: "Rechazada")
                        ItemEsimPurchased(estatus: "Rechazada")
                        ItemEsimPurchased(estatus: "Aprobada")
                    })
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct DetailEsimPurchased:View {
    
    @Binding var show:Bool
    
    var body: some View {
        VStack {
            GroupBox {
                Image(.simEsim)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100,height: 100)
                Text("5566837465")
                Text("Aprobada")
                    .foregroundColor(.green)

                Button {
                    
                } label: {
                    Text("Instalar eSIM")
                        .foregroundColor(.white)
                }
                .frame(width: 250,height: 30)
                .background(.blue)
                .clipShape(Capsule())
                Button {
                    
                } label: {
                    Text("Reenviar QR")
                        .foregroundColor(.white)
                }
                .frame(width: 250,height: 30)
                .background(.blue)
                .clipShape(Capsule())

                Button {
                    
                } label: {
                    Text("Cambiar eSIM de dispositivo")
                        .foregroundColor(.white)
                }
                .frame(width: 250,height: 30)
                .background(.blue)
                .clipShape(Capsule())
            }
            Button {
                withAnimation(.snappy){
                    show.toggle()
                }
            } label: {
                Image(systemName: "xmark.circle")
                    .imageScale(.large)
                    .foregroundStyle(.black)
                
            }
            .padding(.top,30)
        }
    }
}

struct ItemEsimPurchased:View {
    var estatus:String
    var body: some View {
        GroupBox {
            Image(.simEsim)
                .resizable()
                .scaledToFit()
            Text(estatus)
                .font(.system(size: 10))
                .foregroundColor(estatus == "Aprobada" ? .green : .red)
            Text("******8090")
                .font(.system(size: 10))
            Text("Ver mas")
                .font(.system(size: 10))
                .underline()
        }
    }
}

#Preview {
    CustomDialog()
}
