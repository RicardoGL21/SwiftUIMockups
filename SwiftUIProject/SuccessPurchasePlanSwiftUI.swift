//
//  SuccessPurchasePlanSwiftUI.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 23/10/24.
//

import SwiftUI

struct SuccessPurchasePlanSwiftUI: View {
    var body: some View {
        VStack{
            Text("¡Recarga exitosa!")
                .font(.system(size: 17.0,weight: .bold))
            Text("Monto recargado: $250")
                .font(.system(size: 15.0))
                .padding(.top)
            Text("Número: 5555555555")
                .font(.system(size: 15.0))
            Text("Folio: webp_3201024234")
                .font(.system(size: 15.0))
            Text("En breve recibirás un correo de confirmación.")
                .padding(.top)
                .font(.system(size: 15.0))
            Text("¡Sigue disfrutando de la mejor telefonía!")
                .padding(.top)
                .font(.system(size: 15.0,weight: .bold))
            
            Button {
                print("Recargas")
            } label: {
                Text("Ver mis recargas")
            }
            .buttonStyle(MyCustomButtonAccentUI())
            .padding(.top)

            
            Spacer()
        }
    }
}

#Preview {
    SuccessPurchasePlanSwiftUI()
}
/*
 
 @State var startPaypalBtn = false
 
 func doPurchasePaypal(){
     let user = UserBuilder.instance()
     let cliente =  user.local.user.cliente ?? userTemp?.cliente
     let emailUser = cliente?.email ?? ""
     
     let request = RequestPurchaseESIMPaypal(marca: Constants.brand, correo: emailUser, folio: folio, cp: self.cpFill ?? "", nombre_plan: eSIMCatalog?.nombre ?? "", idplan: eSIMCatalog!.ofertaprimaria ?? "", importe: eSIMCatalog!.importe ?? "", nueva_esim: ((self.decisionRoute ?? "new").elementsEqual("new")), dn: "")
     
     viewModel.purchaseEsimPaypal(folio: folio, request: request, dataLoginRequest: dataLoginRequest) { result in
         switch result {
         case .success(let success):
             startPaypalBtn = true
         case .failure(let failure):
             errorMessage = failure.message
             showPopupError = true
         }
     }
 }
 
 ZStack {
     
     PaypalTriggerRepresentable(storyboardName: "esImFlow", viewControllerIdentifier: "PaypalTriggerViewController",eSIMCatalog: eSIMCatalog, folio: folio,callbackStatusPaypal: { result in
         switch result {
         case .cancel:
             print("Se cancelo")
             folio =  "\(R.string.localizable.str_folio_esim())\(NSDate().timeIntervalSince1970 * 1000)"
             //MARK:   Borrar
             //folio = "web_1725984890408"
             //waitForTheEsim()
         case .error:
             print("Hubo un error")
             folio =  "\(R.string.localizable.str_folio_esim())\(NSDate().timeIntervalSince1970 * 1000)"
         case .success:
             print("Si lo compro")
             self.delegateMain?.sendImageRekognition()
             waitForTheEsim()
         }
         
         startPaypalBtn = false
         
     }, isButtonEnabled: startPaypalBtn)
     .frame(width: 100,height: 20)
     
     Button(action: {
         if !viewModel.isLoadingPaypal {
             if !acceptDeviceEsim || !acceptTermsAndConditions {
                 showPopupAcceptTerms = true
             } else {
                 doPurchasePaypal()
             }
         }
     }, label: {
         HStack {
             Image(uiImage: UIImage(resource: .paypalWhite))
                 .resizable()
                 .scaledToFit()
                 .frame(width: 20)
             Text(viewModel.isLoadingPaypal ? "Cargando..." : "Pagar con PayPal")
                 .font(.callout)
             Spacer()
         }
         .frame(width: 320)
     })
     .buttonStyle(MyCustomButtonLoadingUI(isLoading: viewModel.isLoadingPaypal))
     
 }
 


 
*/
