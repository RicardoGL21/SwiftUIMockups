//
//  LoadingWithTextSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 30/08/24.
//

import SwiftUI


struct LoadingWithTextSwiftUI: View {
    let texts = ["Cargando tu nueva conexión mágica... ¡No muevas el celular, está concentrado!", "Conectando a una velocidad casi cuántica... casi.", "¡Sujeta fuerte, tu nueva eSIM está aterrizando!", "Espera... casi terminamos de darle súper poderes a tu teléfono.", "Creando un enlace directo al ciberespacio... ¡prepárate!","Evitando trolls digitales mientras cargamos tu eSIM..."]
    
    @State private var currentIndex = 0
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack {
            
            Image(.newProfileImg)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            
            Text(texts[currentIndex])
                .font(.system(size: 20.0))
                .padding()
                .multilineTextAlignment(.center)
                .onAppear {
                    timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                        withAnimation {
                            currentIndex = (currentIndex + 1) % texts.count
                        }
                    }
                }
                .onDisappear {
                    timer?.invalidate()
                    timer = nil
                }
        }
    }
}

#Preview {
    LoadingWithTextSwiftUI()
}
