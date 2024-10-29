//
//  HistoryTopupSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 17/10/24.
//

import SwiftUI

struct HistoryTopupSwiftUI: View {
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Image(._3586362ChecklistDocumentListPaperIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
            }.frame(maxWidth: .infinity)
                .padding(.trailing,17)
            
            List(0...7, id: \.self) { index in
                ItemHistoryTopupSwiftUI()
                    .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            Spacer()
        }
    }
}

struct ItemHistoryTopupSwiftUI:View {
    var body: some View {
        VStack {
            
            HStack(alignment: .center) {
                Image(.iconCalendar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .padding(.trailing,6)
                Text("CHIDO")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
                Text("15/10/2024")
                    .font(.system(size: 15, weight: .bold))
                Spacer()
                Text("$289.00")
                    .font(.system(size: 15, weight: .bold))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.top,8)
            
            HStack {
                Image(.iconFolio)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .padding(.trailing,6)
                
                Text("Folio: pilp_12345678695")
                    .font(.system(size: 15))
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.top,5)
            
            HStack {
                Image(.iconCard)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .padding(.trailing,6)
                
                Text("Pago pendiente")
                    .font(.system(size: 15))
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.top,5)
            .padding(.bottom,8)
            
        }
        .frame(maxWidth: .infinity)
        .background(.green.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 12.0))
    }
}

#Preview {
    HistoryTopupSwiftUI()
}
