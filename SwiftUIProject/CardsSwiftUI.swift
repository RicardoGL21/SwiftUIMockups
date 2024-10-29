//
//  CardsSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 22/10/24.
//

import SwiftUI

struct CardsSwiftUI: View {
    var body: some View {
        List(0...3,id: \.self) { index in
            ItemCardSwiftUI()
        }
        .frame(height: 100)
    }
}

struct ItemCardSwiftUI:View {
    var body: some View {
        VStack{
            HStack{
                Image(.bgCard)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                
                VStack {
                    Text("Nombre del dueño de la tarjeta")
                    Text("XXXX XXXX XXXX 4403")
                }
                .font(.system(size: 11.0))
                
                Button {
                    
                } label: {
                    Text("Pagar")
                        .padding(.horizontal,19)
                }
                .buttonStyle(MyCustomButtonUI())

            }
        }
    }
}

#Preview {
    CardsSwiftUI()
}
