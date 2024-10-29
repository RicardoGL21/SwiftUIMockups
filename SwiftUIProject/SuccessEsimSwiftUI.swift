//
//  SuccessEsimSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 02/09/24.
//

import SwiftUI

struct SuccessEsimSwiftUI: View {
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 16.0)
                VStack {
                    
                    Text("Tu pago sigue en revisión")
                        .foregroundColor(.white)
                        .font(.system(size: 30.0,weight: .bold))
                        .padding()
                        .padding(.top)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text("Para ver si la compra de tu eSIM fue aprobada puedes entrar desde la seccion de \"Inicio\" en el apartado \"Mi eSIM\".")
                        .foregroundColor(.white)
                        .padding()
                        .font(.system(size: 19.0))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Cerrar")
                            .font(.system(size: 14.0))
                            .frame(width: 170)
                    })
                    .padding(.bottom,30)
                    
                                        
                    Button(action: {
                        
                    }, label: {
                        Text("Cerrar")
                            .font(.system(size: 14.0))
                            .frame(width: 170)
                    })
                    .buttonStyle(MyCustomButtonAccentUI())
                    .padding(.bottom,30)
                    
                    
                }
            }
        }
        .padding()

    }
}

#Preview {
    SuccessEsimSwiftUI()
}
