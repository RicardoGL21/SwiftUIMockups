//
//  AutoRenewView.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 19/07/24.
//

import SwiftUI

struct AutoRenewView: View {
    
    var planes = [Plan(nombre: "Disfruta", color: .disfruta, precio: "$139.00"),Plan(nombre: "Explora", color: .explora, precio: "$139.00"),Plan(nombre: "Vuela", color: .vuela, precio: "$139.00"),Plan(nombre: "Fan", color: .orange, precio: "$139.00")]
    
    var body: some View {
        VStack {
            Text("Autorecarga")
                .font(.title)
                .bold()
            Text("Ahorra y no te preocupes por recargar cada mes, nosotros nos ocupamos de eso")
                .padding(.horizontal)
                .padding(.top,5)
                .multilineTextAlignment(.center)
            Text("1. Selecciona tu plan")
                .font(.footnote)
                .padding(.horizontal)
                .padding(.top,5)
                .multilineTextAlignment(.center)
            List(planes, id: \.self) {plan in
                ItemPlanAutoRenew(nombre: plan.nombre, color: plan.color, hiddePicker: false)
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            VStack {
                Text("2. Selecciona la tarjeta donde se haran los cargos")
                    .font(.footnote)
                    .padding(.horizontal)
                    .padding(.top,5)
                    .multilineTextAlignment(.center)
                HStack {
                    Text("Metodo de pago:")
                    Spacer()
                    Text("Selecciona una tarjeta")
                        .foregroundStyle(.gray)
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal)
                .padding(.top,9)
                .padding(.bottom, 9)
                Button {
                    
                } label: {
                    Text("Confirmar Autorecarga")
                        .foregroundStyle(.white)
                        .padding(.vertical,8)
                }
                .frame(maxWidth: .infinity)
                .background(.blue)
                .clipShape(Capsule())
                .padding(.horizontal)
            }
        }
    }
}

struct ItemPlanAutoRenew: View {
    
    var nombre:String
    var color:Color
    var hiddePicker:Bool
    var dateConfigured:String?
    @State private var animateGradient = false
    
    var body: some View {
        ZStack {
            
            if self.dateConfigured != nil {
                
            } else {
                LinearGradient(colors: [color, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .onAppear {
                        withAnimation(.snappy(duration: 5.0).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
                    .opacity(1)
                    .clipShape(RoundedRectangle(cornerRadius:12))
            }
            
            VStack {
                HStack {
                    Text(nombre)
                        .bold()
                    Spacer()
                    Image(.radioOff)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20,height: 20)
                        .opacity(hiddePicker ? 0 : 1)
                }
                .padding(.top)
                .padding(.horizontal)
                
                HStack{
                    Text("$139.00/mes")
                    Spacer()
                    if let date = self.dateConfigured {
                        Text("Configurado desde: \(date)")
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Text("3GB, Incluye llamadas y SMS, datos y llamadas en USA y Canada, Comparte datos, Redes sociales ilimitadas*")
                    Spacer()
                }
                .padding(.horizontal)
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGray5).opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom,15)
    }
}

#Preview {
    AutoRenewView()
}

struct Plan:Hashable {
    var nombre:String
    var color:Color
    var precio:String
}
