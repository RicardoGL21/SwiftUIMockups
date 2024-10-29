//
//  RechargeFlow.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 16/10/24.
//

import SwiftUI
import SwiftUIPager

struct RechargeFlowSwiftUI: View {
    
    @State var optionSelected:Int = 0
    
    var body: some View {
        VStack {
            HStack(spacing:0) {
                
                Button {
                    optionSelected = 0
                } label: {
                    Text("Recargas")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 17,weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.vertical,8)
                }
                .frame(maxWidth: .infinity)
                .background(optionSelected == 0 ? .red : .gray)
                .clipShape(BottomRoundedCorners(radius: 10.0))
                
                Button {
                    optionSelected = 1
                } label: {
                    Text("Cupones")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 17,weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.vertical,8)
                }
                .frame(maxWidth: .infinity)
                .background(optionSelected == 1 ? .red : .gray)
                .clipShape(BottomRoundedCorners(radius: 10.0))
            }
            
            
            if optionSelected == 0 {
                RechargeScreenSwiftUI()
            } else if optionSelected == 1 {
                Text("Cupones")
            }
            
            Spacer()
            
        }
    }
    
    
}

struct RechargeScreenSwiftUI:View {
    
    @State private var page: Page = .first()
    @State var index = 0
    
    var body: some View {
        VStack {
            Text("Elige tu plan")
                .padding(.top)
                .font(.system(size: 20,weight: .bold))
            
            HStack {
                Image(systemName: "chevron.left")
                    .padding(.leading,10)
                    .font(.title2)
                    .frame(maxHeight: 300)
                    .onTapGesture {
                        goToBackPage()
                    }
                
                Pager(page: page, data: Array(0...2), id:\.self) { index in
                    ItemPlan()
                }
                .onPageChanged({ (newIndex) in
                    index = newIndex
                })
                .swipeInteractionArea(.allAvailable)
                .multiplePagination()
                .itemAspectRatio(0.8)
                .itemSpacing(160)
                .interactive(scale: 0.8)
                .frame(maxHeight: 510)
                .frame(height: 460)
                
                Image(systemName: "chevron.right")
                    .padding(.trailing,10)
                    .font(.title2)
                    .frame(maxHeight: 300)
                    .onTapGesture {
                        goToNextPage()
                    }
            }
            
            PageControl(index: $index, maxIndex: 2)
            
            Text("Historial de recargas")
                .underline()
            
            Spacer()
        }
    }
    
    func goToNextPage() {
        let nextPage = page.index + 1
            withAnimation {
                index = nextPage
                page.update(.new(index: nextPage)) // Actualiza el índice de la página con animación
            }
    }
    
    func goToBackPage() {
        let backPage = page.index - 1
            withAnimation {
                index = backPage
                page.update(.new(index: backPage)) // Actualiza el índice de la página con animación
            }
    }
    
}

#Preview {
    RechargeFlowSwiftUI()
}

struct ItemPlan:View {
    var body: some View {
        VStack {
            VStack(spacing:0) {
                
                Rectangle()
                    .foregroundStyle(.red)
                    .frame(height: 35)
                
                Text("IDOLO")
                    .font(.system(size: 40,weight: .bold))
                
                HStack(spacing:0){
                    Text("15GB")
                        .font(.system(size: 50,weight: .bold))
                    Text("/MES")
                        .font(.system(size: 20,weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(.red)
                .padding(.bottom,10)
                
                ForEach(0...3, id: \.self) { index in
                    Text("Incluye llamadas y SMS")
                        .font(.system(size: 13))
                }
                
                Image(.redes)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(height: 20)
                    .padding(.top,20)
                    .shadow(color: .gray, radius: 10, x: 0, y: 5)
                    .foregroundColor(.red)
                
                Spacer()
            }
            .frame(maxHeight: 290)
            .frame(height: 290)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .background(
                RoundedRectangle(cornerRadius: 20) // Fondo con esquinas redondeadas
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 10, x: 0, y: 0) // Sombra en el fondo
            )
            
            Button {
                
            } label: {
                Text("Recarga $300")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(MyCustomButtonAccentRechargeUI())
            .padding(.horizontal)
            .padding(.vertical,10)
            
            Button {
                
            } label: {
                Text("Autorecarga $300")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(MyCustomButtonAccentRechargeUI())
            .padding(.horizontal)
            .padding(.bottom,10)
            
            Button {
                
            } label: {
                Text("Anual c/mes $300")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(MyCustomButtonAccentRechargeUI())
            .padding(.horizontal)
            
        }
    }
}

struct BottomRoundedCorners: Shape {
    var radius: CGFloat = 25
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Define the top-left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // Top side
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius)) // Right side until the curve
        path.addQuadCurve(to: CGPoint(x: rect.maxX - radius, y: rect.maxY),
                          control: CGPoint(x: rect.maxX, y: rect.maxY)) // Bottom-right corner curve
        path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY)) // Bottom side
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - radius),
                          control: CGPoint(x: rect.minX, y: rect.maxY)) // Bottom-left corner curve
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY)) // Left side

        return path
    }
}
