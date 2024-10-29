//
//  EsimAvalibleSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 28/08/24.
//

import SwiftUI
import SwiftUIPager

struct EsimAvalibleSwiftUI: View {
    
    @State var index = 0
    
    var body: some View {
        ScrollView{
            VStack {
                Pager(page: .withIndex(0), data: Array(0...2), id:\.self) { index in
                    if index == 0 {
                        CardOfEsimTutorial(title: "Que es una eSIM?", description: "La eSIM es una SIM virtual que se instala en tu equipo y te permite navegar",icon: UIImage(resource: .icoEsim))
                    } else if index == 1 {
                        CardOfEsimTutorial(title: "¿Puedo usar una eSIM de Pillo con otra SIM física?", description: "¡Sí, puedes usar la eSIM de Pillo junto a otra SIM física sin problema!",icon: UIImage(resource: .icoTwicesim))
                    } else if index == 2 {
                        CardOfEsimTutorial(title: "Beneficios de una eSIM ", description: "- Se instala de inmediato en tu dispositivoz\n- Es posible combinar la señal de dos compañias\n- La eSIM no se deteriora por desgaste físico",icon: UIImage(resource: .icoCheck))
                    }
                }
                .onPageChanged({ (newIndex) in
                    index = newIndex
                })
                .swipeInteractionArea(.allAvailable)
                .multiplePagination()
                .itemAspectRatio(0.8)
                .itemSpacing(160)
                .frame(maxHeight: 250)
                .frame(height: 190)
                
                Spacer()
                
                PageControl(index: $index, maxIndex: 4)
                
                Text("Verifica tu compatibilidad")
                    .bold()
                    .padding()
                
                Text("Si tienes un iPhone XS, XS Max, XR o cualquier modelo posterior con iOS 12.1 o superior, puedes usar una eSIM")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,20)
                
                Text("Verificar compatibilidad")
                    .foregroundStyle(.blue)
                    .padding()
                    .underline()
                
                Text("Antes de comprar, verifica que tu dispositivo sea compatible con eSIM")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,20)
                    .padding(.bottom)
                
                Button(action: {
                    
                }, label: {
                    Text("Comprar eSIM")
                })
                .buttonStyle(MyCustomButtonUI())
                
                /*HStack {
                    Rectangle()
                        .frame(height: 1)
                    Text("ó")
                    Rectangle()
                        .frame(height: 1)
                }
                .padding(.horizontal,50)
                .padding(.bottom,15)
                .padding(.top,15)
                
                Button(action: {
                    
                }, label: {
                    Text("Comprar SIM fisica")
                })*/
                
                Spacer()
            }
        }
    }
}

struct MyCustomButtonUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct MyCustomButtonAccentUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct MyCustomButtonAccentRechargeUI: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal,10)
            .padding(.vertical,5)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct CardOfEsimTutorial: View {
    
    var title:String
    var description:String
    var image:UIImage?
    var icon:UIImage?
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                
                VStack {
                    HStack(alignment:.top) {
                        if icon != nil {
                            Image(uiImage: icon!)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 18)
                        }
                        Text("\(title)")
                            .bold()
                            .padding(.bottom)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14.0))
                    }
                    Text("\(description)")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 14.0))
                    if image != nil {
                        Image(uiImage: image!)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                    }
                }
                .frame(minWidth: 270,minHeight: 140)
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.blue),lineWidth: 3)
                }
            }
        }
    }
    
}

#Preview {
    EsimAvalibleSwiftUI()
}

struct PageControl: View {
    @Binding var index: Int
    let maxIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color.blue : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(15)
    }
}
