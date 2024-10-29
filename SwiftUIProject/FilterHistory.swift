import SwiftUI
import PopupView

struct StatusFilterPopup: View {
    @State private var selectedStatus: String = "Todas"
    @State private var startDate = Date()
    @State private var endDate = Date()
    @Binding var isPresented: Bool // Para cerrar el popup

    let statuses = ["Todas", "Aceptadas", "Pendientes", "Fallidas"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Selecciona Estatus y Fechas")
                .font(.headline)
            
            Picker("Estatus", selection: $selectedStatus) {
                ForEach(statuses, id: \.self) { status in
                    Text(status).tag(status)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            DatePicker("Fecha Inicial", selection: $startDate, displayedComponents: .date)
            DatePicker("Fecha Final", selection: $endDate, displayedComponents: .date)

            HStack {
                Button("Aplicar") {
                    // Lógica para aplicar filtros
                    print("Estatus: \(selectedStatus), Desde: \(startDate), Hasta: \(endDate)")
                    isPresented = false // Cerrar el popup
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("Cancelar") {
                    isPresented = false // Cerrar el popup
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}

// Vista principal para mostrar el popup
struct ContentViewFilter: View {
    @State private var showPopup = false

    var body: some View {
        VStack {
            Button("Mostrar Filtros") {
                showPopup = true
            }
            .popup(isPresented: $showPopup) {
                StatusFilterPopup(isPresented: $showPopup)
            }
        }
        .padding()
    }
}

struct ContentViewFilterPreview: PreviewProvider {
    static var previews: some View {
        ContentViewFilter()
    }
}
