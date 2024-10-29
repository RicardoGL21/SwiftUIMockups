//
//  AutoRenewSelectedView.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 19/07/24.
//

import SwiftUI

struct AutoRenewSelectedView: View {
    
    @State var acceptCoupon:Bool = true
    
    var body: some View {
        VStack{
            Text("Autorecarga")
                .font(.title)
                .bold()
            Text("Estos son los detalles de tu autorecarga configurada:")
                .padding(.horizontal)
                .padding(.top,5)
                .multilineTextAlignment(.center)
            ItemPlanAutoRenew(nombre: "Explora", color: .explora, hiddePicker: true,dateConfigured: "19/02/2023")
            
            HStack {
                Text("Metodo de pago:")
                Spacer()
                Text("XXXX XXXX XXXX 4508")
                    .foregroundStyle(.gray)

            }
            .padding(.horizontal)
            .padding(.bottom, 9)
            
            HStack {
                Text("Número Diri:")
                Spacer()
                Text("5566837465")
                    .foregroundStyle(.gray)

            }
            .padding(.horizontal)
            .padding(.bottom, 9)
            
            HStack {
                Text("Fecha de próximo cargo:")
                Spacer()
                Text("19/08/2024")
                    .foregroundStyle(.gray)

            }
            .padding(.horizontal)
            .padding(.bottom, 9)
            
            HStack {
                Text("Estado de último cargo:")
                Spacer()
                Text("Pago aceptado")
                    .foregroundStyle(.gray)

            }
            .padding(.horizontal)
            .padding(.bottom, 9)
            
            HStack {
                Toggle(isOn: $acceptCoupon){
                    
                }
                .labelsHidden()
                .disabled(true)
                Spacer()
                Text("Quiero que se canjeen primero todos mis cupones vigentes en lugar de que se realice una recarga automática en el momento que sea necesario")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding(.top,8)
            .padding(.horizontal)
            
            Button {
                
            } label: {
                Text("Modificar autorecarga")
                    .foregroundStyle(.white)
                    .padding(.vertical,8)
            }
            .frame(maxWidth: .infinity)
            .background(.blue)
            .clipShape(Capsule())
            .padding()
            Button {
                
            } label: {
                Text("Cancelar autorecarga")
                    .foregroundStyle(.white)
                    .padding(.vertical,8)
            }
            .frame(maxWidth: .infinity)
            .background(.red)
            .clipShape(Capsule())
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    AutoRenewSelectedView()
}
