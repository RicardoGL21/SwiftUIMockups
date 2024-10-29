//
//  DecisionEsimSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 28/08/24.
//

import SwiftUI

struct DecisionEsimSwiftUI: View {
    
    @State private var selectedOption:Int?
    
    var body: some View {
        VStack {
            
            ScrollView {
                Text("Adquiere una eSIM")
                    .font(.system(size: 16.0,weight: .bold))
                Text("Compra una eSIM e instálala al instante. Incluye un plan de 7 días de servicio ilimitado*.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16.0))
                    .padding()
                Text("¿Qué te gustaría hacer?")
                    .font(.system(size: 16.0,weight: .bold))
                    .padding()
                
                CardDecisionEsim(description: "Aún no soy cliente PilloFon y quiero una eSIM", image: selectedOption == 0 ? .radioOn : .radioOff)
                    .padding(.horizontal)
                    .padding(.bottom,10)
                    .onTapGesture {
                        selectedOption = 0
                    }
                CardDecisionEsim(description: "Soy cliente PilloFon y quiero un número nuevo en mi eSIM", image: selectedOption == 1 ? .radioOn : .radioOff)
                    .padding(.horizontal)
                    .padding(.bottom,10)
                    .onTapGesture {
                        selectedOption = 1
                    }
                CardDecisionEsim(description: "Soy cliente PilloFon y quiero trasladar mi número de la SIM física a una eSIM", image: selectedOption == 2 ? .radioOn : .radioOff)
                    .padding(.horizontal)
                    .onTapGesture {
                        selectedOption = 2
                    }
                
                Spacer()
            }
            
            Button(action: {
                
            }, label: {
                Text("Continuar")
            })
            .padding(.vertical,10)
            .buttonStyle(MyCustomButtonUI())
        }
    }
}

struct CardDecisionEsim: View {
    var description:String
    var image:UIImage
    
    var body: some View {
        VStack {
            HStack {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                
                Spacer()
                
                Text("\(description)")
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .frame(height: 100)
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black,lineWidth: 3)
            }
        }
    }
}

#Preview {
    DecisionEsimSwiftUI()
}
