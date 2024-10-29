//
//  Saved.swift
//  SwiftUIProject
//
//  Created by Ricardo Garcia on 17/10/24.
//

/*import Foundation
import RxSwift
import FirebaseAnalytics
import SwiftUI

class ViewModel:ObservableObject {
    
    @Published var responseEraseUser:BaseResponse? = nil
    @Published var eSIMCatalog:PlanSIM? = nil
    @Published var listPaymentMethod: [PaymentMethodDiri?]? = nil
    @Published var listCards: [Card?]? = nil
    @Published var esimAvailable: Int? = nil
    
    @Published var errorMessage:String?
    @Published var isLoading = false
    @Published var isLoadingPaypal = false
    @Published var isLoadingOTP = false
    
    let defaults = UserDefaults.standard
    
    var disposeBag = DisposeBag()
    
    func eraseUser() async throws {
        isLoading = true
        errorMessage = nil
        
        let userBuilder = UserBuilder.instance()
        if let user = userBuilder.user.cliente{
            
            var dn = ""
            if !userBuilder.user.lineas.isEmpty {
                dn = userBuilder.user.lineas[0].datoslinea?.dn ?? ""
            }
            
            let request = RequestDeleteMyAccount(correo: user.email ?? "", marca: Constants.brand, dn: dn)
            ApiClient.deleteMyAccount(dataRequest: request)
                .observeOn(MainScheduler.asyncInstance)
                .do(onNext: {
                    result in
                    self.isLoading = false
                    self.responseEraseUser = result
                }, onError: { error in
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }, onSubscribe: {
                    
                })
                .subscribe().disposed(by: disposeBag)
            
        }
        
    }
    
    func getStatusVentaEsim() {
        isLoading = true
        errorMessage = nil
        
        ApiClient.getCatalogEsim()
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: {
                result in
                if (result.codRespuesta == "OK" ){
                    if (result.listadoPlanesEsim != nil){
                        if (!result.listadoPlanesEsim!.isEmpty){
                            self.esimAvailable = result.esims_disponibles
                            
                            let planes = result.listadoPlanesEsim
                            let planesSorted = planes?.sorted(by: { $0.importe?.floatValue ?? 0 < $1.importe?.floatValue ?? 0})
                            self.eSIMCatalog = planesSorted![0]
                        }
                    }
                }
                
                self.isLoading = false
            }, onError: { error in
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }, onSubscribe: {
                
            })
            .subscribe().disposed(by: disposeBag)
    }
    
    func getMethodPayment(userTemp:PerfilClienteApp?) {
        isLoading = true
        errorMessage = nil
        
        let user = UserBuilder.instance()
        let lineas = user.local.user.lineas
        let defaultLine = lineas.isEmpty ? nil : lineas[safe: 0]
        let cliente =  user.local.user.cliente ?? userTemp?.cliente
        ApiClient.getPaymentMethod(cliente: cliente)
            .observeOn(MainScheduler.instance)
            .do(onNext: {
                result in
                self.isLoading = false
                
                if let unwrapListMethods = result.lista_metodos, unwrapListMethods.count > 0 {
                    self.listPaymentMethod = unwrapListMethods.sorted { ($0.id ?? 0 < $1.id ?? 0)}
                } else {
                    self.listPaymentMethod = nil
                }
                
            }, afterNext: {_ in
                
            }, onError: { e in
                self.isLoading = false
                self.errorMessage = e.localizedDescription
                
            }, afterError: {_ in
                
            }, onSubscribe : {
                
            }).subscribe().disposed(by: self.disposeBag)
    }
    
    func getCreditCards(userTemp:PerfilClienteApp?) {
        
        let user = UserBuilder.instance()
        let request = RequestValidationMP(marca: Constants.brand, dn: user.user.cliente?.dn ?? "0000000000", correo: (userTemp?.cliente?.email ?? user.user.cliente?.email) ?? "")
        ApiClient.getCardsMP(dataRequest: request)
            .observeOn(MainScheduler.instance)
            .do(onNext: {
                result in
                if let listaTarjetas = result.listaTarjetas {
                    var activeCards: [Card] = []
                    if result.listaTarjetas!.count > 0{
                        for item in result.listaTarjetas! {
                            if item.estatus_tarjeta?.lowercased() == "ok" {
                                activeCards.append(item)
                            }
                        }
                    }
                    self.listCards = activeCards
                    
                } else {
                    self.listCards = nil
                }
            }, afterNext: {_ in
                
            }, onError: { e in
                
            }, afterError: { error in
                
            }, onSubscribe : {
                
            }).subscribe().disposed(by: disposeBag)
    }
    
    func getPurchasedEsim(folio:String,email:String,completion: @escaping (Result<ESIMSales, ErrorOfService>) -> Void) {
        isLoading = true
        let request = RequestStatusPurchaseESIM(marca: Constants.brand, correo: email)
        ApiClient.getStatusPurcharseESIM(dataRequest: request)
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: {
                result in
                if (result.codRespuesta == "OK" ){
                    if let listOfEsims = result.lista_ventasesim, !listOfEsims.isEmpty {
                        var foundTheEsim = false
                        for esim in listOfEsims {
                            if esim.folio_venta == folio {
                                if let statusEsim = esim.estatus_venta, statusEsim.uppercased() == "PAGO_EXITOSO" {
                                    foundTheEsim = true
                                    completion(.success(esim))
                                    self.isLoading = false
                                }
                            }
                        }
                        
                        if !foundTheEsim {
                            completion(.failure(ErrorOfService(message: "No se encontro la esim")))
                        }
                    } else {
                        completion(.failure(ErrorOfService(message: "No hay eSIMs")))
                    }
                }
            }, onError: { error in
                completion(.failure(ErrorOfService(message: error.localizedDescription)))
            }, onSubscribe: {
                
            })
            .subscribe().disposed(by: disposeBag)
    }
    
    func purchaseEsimMP(request:RequestPurchaseESIM, dataLoginRequest:LoginRequest?,completion: @escaping (Result<ResponsePurcharseESIM, ErrorOfService>) -> Void) {
        isLoading = true
        errorMessage = nil
        
        ApiClient.purcharseESIM(dataRequest: request)
            .observeOn(MainScheduler.asyncInstance)
            .do(onNext: {
                result in
                
                if result.codRespuesta != nil {
                    if (result.codRespuesta == "OK" ){
                        do{
                            try AnalyticsUtils.trackEventFirebase(event: FirebaseAnalytics.AnalyticsEventPurchase, params: [FirebaseAnalytics.AnalyticsParameterPrice: self.eSIMCatalog?.importe, FirebaseAnalytics.AnalyticsParameterCurrency: "MXN"])
                        }
                        catch{
                            
                        }
                        
                        self.defaults.setValue(result.folio_venta ?? "", forKey: "last_folio_diri")
                        completion(.success(result))
                        //self.delegateMain?.sendImageRekognition()
                    } else {
                        self.isLoading = false
                        completion(.failure(ErrorOfService(message: result.detalle ?? "")))
                    }
                } else {
                    self.isLoading = false
                    completion(.failure(ErrorOfService(message: R.string.localizable.default_error_gral())))
                }
            }, onError: { error in
                self.isLoading = false
                
                if error != nil {
                    switch error {
                    case ApiError.network:
                        completion(.failure(ErrorOfService(message: R.string.localizable.default_error_gral())))
                    case is ApiErrorDiriMessage:
                        let customError = error as! ApiErrorDiriMessage
                        if customError.codRespuesta == "ERROR63"{
                            //no sims available
                            //Save session
                            if (dataLoginRequest != nil){
                                let user = UserBuilder.instance()
                                let preferences = PreferencesLocal(USER_EMAIL: dataLoginRequest!.datosClienteApp.correo, APP_NAME_USER: dataLoginRequest!.datosClienteApp.nombre, APP_USER: dataLoginRequest!.usuario, APP_ID_FB: dataLoginRequest!.idFaceBook, APP_ID_APPLE: dataLoginRequest!.idApple, APP_ID_GE: dataLoginRequest!.idGoogle, APP_PASS: dataLoginRequest!.password)
                                user.user.preferences = preferences
                                user.saveSessionPref()
                            }
                            
                            completion(.failure(ErrorOfService(message: customError.detalle ?? R.string.localizable.default_error_gral())))
                            //self.performSegue(withIdentifier: R.segue.purchaseEsimController.no_sim.identifier, sender: self)
                        }
                        else{
                            completion(.failure(ErrorOfService(message: customError.detalle ?? R.string.localizable.default_error_gral())))
                        }
                        break
                    default:
                        completion(.failure(ErrorOfService(message: R.string.localizable.default_error_gral())))
                    }
                } else {
                    completion(.failure(ErrorOfService(message: R.string.localizable.default_error_gral())))
                }
            }, onSubscribe: {
                
            })
        .subscribe().disposed(by: disposeBag)
    }
    
    func purchaseEsimPaypal(folio:String,request:RequestPurchaseESIMPaypal,dataLoginRequest:LoginRequest?,completion: @escaping (Result< ResponsePurcharseESIM, ErrorOfService>) -> Void) {
            
        isLoadingPaypal = true
        
            ApiClient.purcharseESIMPaypal(dataRequest: request)
                .observeOn(MainScheduler.asyncInstance)
                .do(onNext: {
                    result in
                    //self.hideLoading()
                    self.isLoadingPaypal = false
                    if (result.codRespuesta == "OK" ){
                        do{
                            try AnalyticsUtils.trackEventFirebase(event: FirebaseAnalytics.AnalyticsEventPurchase, params: [FirebaseAnalytics.AnalyticsParameterPrice: self.eSIMCatalog?.importe, FirebaseAnalytics.AnalyticsParameterCurrency: "MXN"])
                        }
                        catch{
                            
                        }
                        //SetupPaypal
                        
                        completion(.success(result))
                    } else {
                        completion(.failure(ErrorOfService(message: R.string.localizable.default_error_gral())))
                        //self.displayError(R.string.localizable.oops(), R.string.localizable.default_error_gral())
                    }
                }, onError: { error in
                    self.isLoadingPaypal = false
                    switch error {
                        case ApiError.network:
                            //self.displayError(error)
                        completion(.failure(ErrorOfService(message: error.localizedDescription ?? R.string.localizable.default_error_gral() )))
                        case is ApiErrorDiriMessage:
                            let customError = error as! ApiErrorDiriMessage
                            if customError.codRespuesta == "ERROR63"{
                                //no sims available
                                //self.hideLoading()
                                //Save session
                                if (dataLoginRequest != nil){
                                    let user = UserBuilder.instance()
                                    let preferences = PreferencesLocal(USER_EMAIL: dataLoginRequest!.datosClienteApp.correo, APP_NAME_USER: dataLoginRequest!.datosClienteApp.nombre, APP_USER: dataLoginRequest!.usuario, APP_ID_FB: dataLoginRequest!.idFaceBook, APP_ID_APPLE: dataLoginRequest!.idApple, APP_ID_GE: dataLoginRequest!.idGoogle, APP_PASS: dataLoginRequest!.password)
                                    user.user.preferences = preferences
                                    user.saveSessionPref()
                                }
                                
                                completion(.failure(ErrorOfService(message: customError.detalle ?? R.string.localizable.default_error_gral())))
                                //self.performSegue(withIdentifier: R.segue.purchaseEsimController.no_sim.identifier, sender: self)
                            }
                            else{
                                completion(.failure(ErrorOfService(message: customError.detalle ?? R.string.localizable.default_error_gral())))
                                //self.displayError(R.string.localizable.oops(), customError.detalle ?? "", self)
                            }
                        break
                        default:
                        completion(.failure(ErrorOfService(message: R.string.localizable.default_error_gral())))
                            //self.displayError(R.string.localizable.oops(), R.string.localizable.default_error_gral(), self)
                    }
                }, onSubscribe: {
                    
                })
            .subscribe().disposed(by: disposeBag)
        
    }
    
    func sendOTPSMS(dn:String, email:String,completion: @escaping (Result<String, ErrorOfService>) -> Void) {
        isLoadingOTP = true
        
        ApiClient.sendCodeLink(dnNumber: dn, marca: Constants.brand, email: email)
            .observeOn(MainScheduler.instance)
            .do(onNext: {
                result in
                //print("This is the response  \(result)")
                self.isLoadingOTP = false
                if (result.codRespuesta == "OK"){
                    completion(.success(result.detalle ?? "El código se envio de forma correcta."))
                }
                else{
                    completion(.failure(ErrorOfService(message: result.detalle ?? R.string.localizable.default_error_gral())))
                }
            }, afterNext: {_ in
                
            }, onError: { e in
                self.isLoadingOTP = false
                completion(.failure(ErrorOfService(message: e.localizedDescription ?? R.string.localizable.default_error_gral())))
            }, onSubscribe : {
                
            }).subscribe().disposed(by: disposeBag)
    }
    
    func linkNumber(dn:String,email:String,code:String,completion: @escaping (Result<String, ErrorOfService>) -> Void) {
        isLoadingOTP = true
        
        ApiClient.linkDNAccount(dnNumber: dn, marca: Constants.brand, email: email, codigo: code, _idRF: nil, _yearRF: nil)
            .observeOn(MainScheduler.instance)
            .do(onNext: {
                result in
                self.isLoadingOTP = false
                if (result.codRespuesta == "OK"){
                    
                    completion(.success(result.detalle ?? ""))
                    self.defaults.set(nil, forKey: "input_number_link")
                }
                else{
                    completion(.failure(ErrorOfService(message: "Por favor comunícate con nosotros desde la opción de ayuda.")))
                    //self.displayError("Error al vincular tu número", "Por favor comunícate con nosotros desde la opción de ayuda.", self)
                }
            }, afterNext: {_ in
                
            }, onError: { e in
                //self.hideLoading()
                self.isLoadingOTP = false
                switch e {
                    case ApiError.network:
                    completion(.failure(ErrorOfService(message: R.string.localizable.default_error_gral())))
                        break
                    case is ApiErrorDiriMessage:
                        let customError = e as! ApiErrorDiriMessage
                        if customError.codRespuesta?.lowercased() == "error29" {
                            completion(.failure(ErrorOfService(message: "Por favor ingresa el último código que fue enviado por SMS")))
                            //self.displayError(R.string.localizable.oops(), "Por favor ingresa el último código que fue enviado por SMS", self)
                        }
                        else if customError.codRespuesta?.lowercased() == "error17" {
                            completion(.failure(ErrorOfService(message: "Hubo un error por favor vuelve a intentarlo o comunicate a soporte")))
                            //self.displayError(R.string.localizable.oops(), "hubo un error por favor vuelve a intentarlo o comunicate a soporte", self)
                        }
                        else{
                            completion(.failure(ErrorOfService(message: customError.detalle ?? R.string.localizable.default_error_gral())))
                            //self.displayError(R.string.localizable.oops(), customError.detalle ?? R.string.localizable.default_error_gral(),self)
                        }
                    default :
                    completion(.failure(ErrorOfService(message: R.string.localizable.default_error_gral())))
                        //self.displayError(R.string.localizable.oops(), R.string.localizable.default_error_gral())
                    break
                }
                
            }, onSubscribe : {
                
            }).subscribe().disposed(by: disposeBag)
    }
    
}

struct ErrorOfService:Error {
    let message:String
}

//DIV
@StateObject private var viewModel = ViewModel()
if viewModel.isLoading {
                LoadingWithTextSwiftUI()
            }
            
            func waitForTheEsim() {
        viewModel.getPurchasedEsim(folio: folioMP.isEmpty ? folio : folioMP, email: userTemp?.cliente?.email ?? "") { result in
            switch result {
            case .success(let esimSales):
                self.eSIMPurchased = esimSales
                goToSuccessScreen = true
            case .failure(let error):
                if self.triesToSeeTheEsim >= 3 {
                    viewModel.isLoading = false
                    esimPending = true
                } else {
                    self.triesToSeeTheEsim += 1
                    repetTheResponse()
                }
            }
        }
    }
    
    struct ErrorOfService:Error {
    let message:String
}
*/


/*
 func weHaveMethodPayment(listMethods:[PaymentMethodDiri?],method:String) -> Bool {
     for theMethod in listMethods {
         if (theMethod?.metodo ?? "").lowercased() == method {
             return true
         }
     }
     return false
 }
 
 func getMethodPayment(userTemp:PerfilClienteApp?) {
     isLoading = true
     errorMessage = nil
     
     let user = UserBuilder.instance()
     let lineas = user.local.user.lineas
     let defaultLine = lineas.isEmpty ? nil : lineas[safe: 0]
     let cliente =  user.local.user.cliente ?? userTemp?.cliente
     ApiClient.getPaymentMethod(cliente: cliente)
         .observeOn(MainScheduler.instance)
         .do(onNext: {
             result in
             self.isLoading = false
             
             if let unwrapListMethods = result.lista_metodos, unwrapListMethods.count > 0 {
                 self.listPaymentMethod = unwrapListMethods.sorted { ($0.id ?? 0 < $1.id ?? 0)}
             } else {
                 self.listPaymentMethod = nil
             }
             
         }, afterNext: {_ in
             
         }, onError: { e in
             self.isLoading = false
             self.errorMessage = e.localizedDescription
             
         }, afterError: {_ in
             
         }, onSubscribe : {
             
         }).subscribe().disposed(by: self.disposeBag)
 }
 */
