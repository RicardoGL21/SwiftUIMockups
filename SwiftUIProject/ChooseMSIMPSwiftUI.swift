//
//  ChooseMSIMPSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 28/10/24.
//

import SwiftUI

struct ChooseMSIMPSwiftUI: View {
    
    //@Binding var msiSelected:String?
    
    @State var msiSelected:String = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            HStack {
                ZStack {
                    HStack {
                        Image(msiSelected == "Contado" ? .radioOn : .radioOff)
                            .resizable()
                            .scaledToFit()
                            .frame(height:20)
                            .padding(.leading,20)
                        Spacer()
                    }
                    HStack {
                        Text("Contado")
                    }
                }
            }
            .frame(height:40)
            .onTapGesture {
                msiSelected = "Contado"
            }
            .background(Color(msiSelected == "Contado" ? .systemGray5 : .white))
            
            HStack {
                ZStack {
                    HStack {
                        Image(msiSelected == "3 meses" ? .radioOn : .radioOff)
                            .resizable()
                            .scaledToFit()
                            .frame(height:20)
                            .padding(.leading,20)
                        Spacer()
                    }
                    HStack {
                        Text("3 meses")
                    }
                }
            }
            .frame(height:40)
            .onTapGesture {
                msiSelected = "3 meses"
            }
            .background(Color(msiSelected == "3 meses" ? .systemGray5 : .white))
            
            HStack {
                ZStack {
                    HStack {
                        Image(msiSelected == "6 meses" ? .radioOn : .radioOff)
                            .resizable()
                            .scaledToFit()
                            .frame(height:20)
                            .padding(.leading,20)
                        Spacer()
                    }
                    HStack {
                        Text("6 meses")
                    }
                }
            }
            .frame(height:40)
            .onTapGesture {
                msiSelected = "6 meses"
            }
            .background(Color(msiSelected == "6 meses" ? .systemGray5 : .white))
            
            HStack {
                ZStack {
                    HStack {
                        Image(msiSelected == "9 meses" ? .radioOn : .radioOff)
                            .resizable()
                            .scaledToFit()
                            .frame(height:20)
                            .padding(.leading,20)
                        Spacer()
                    }
                    HStack {
                        Text("9 meses")
                    }
                }
            }
            .frame(height:40)
            .onTapGesture {
                msiSelected = "9 meses"
            }
            .background(Color(msiSelected == "9 meses" ? .systemGray5 : .white))
            
            HStack {
                ZStack {
                    HStack {
                        Image(msiSelected == "12 meses" ? .radioOn : .radioOff)
                            .resizable()
                            .scaledToFit()
                            .frame(height:20)
                            .padding(.leading,20)
                        Spacer()
                    }
                    HStack {
                        Text("12 meses")
                    }
                }
            }
            .frame(height:40)
            .onTapGesture {
                msiSelected = "12 meses"
            }
            .background(Color(msiSelected == "12 meses" ? .systemGray5 : .white))
            
            if msiSelected != "" {
                Button {
                    print("Comprar")
                } label: {
                    Text("Pagar")
                }

            }
            
            Spacer()
        }
    }
}

#Preview {
    ChooseMSIMPSwiftUI()
}
