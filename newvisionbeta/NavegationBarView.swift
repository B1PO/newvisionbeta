import SwiftUI

struct NavigationBar: View {
    @State private var selectedOption = 1
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color.backgroundColor
                    .ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    contentForSelectedOption() // Método que se encarga del contenido
                }
                .frame(maxHeight: 0)
                .offset(y: -140) // Espacio entre el frame y la barra de pestañas
                .animation(.spring()) 
            }
            
            HStack(spacing: 80) { //Más espacio a los iconos
                CircleOption(selectedOption: $selectedOption, optionNumber: 1, systemIcon: "exclamationmark.circle.fill") {
                    VStack {
                        Text("Text")
                        
                    }
                }
                .modifier(SelectionModifier(selected: selectedOption == 1))
                
                CircleOption(selectedOption: $selectedOption, optionNumber: 2, systemIcon: "camera.fill") {
                    VStack {
                        Text("Text")
                        
                    }
                }
                .modifier(SelectionModifier(selected: selectedOption == 2))
                
                CircleOption(selectedOption: $selectedOption, optionNumber: 3, systemIcon: "square.and.arrow.up.fill") {
                    VStack {
                        Text("Text")
                    }
                }
                .modifier(SelectionModifier(selected: selectedOption == 3))
            }
            .padding(.top, -40)
            .padding(.bottom, -30)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(Color.frameColor)
                    .padding(.horizontal,-30)
                    .padding(.vertical,-57)
            )
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func contentForSelectedOption() -> some View {
        switch selectedOption {
        case 1:
            VStack {
                Text("Info frame")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                    .frame(width: 390, height: 700)
                    .background(Color.frameColor)
                    .cornerRadius(57)
            }
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
            // Agregar transición asimétrica para evitar parpadeos en el cambio de frame
        case 2:
            VStack {
                Text("Camera")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                    .frame(width: 390, height: 700)
                    .background(Color.frameColor)
                    .cornerRadius(57)
            }
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
        case 3:
            VStack {
                Text("File selection")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                    .frame(width: 390, height: 700)
                    .background(Color.frameColor)
                    .cornerRadius(57)
            }
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
        default:
            EmptyView()
        }
    }
}

struct CircleOption<Content: View>: View {
    @Binding var selectedOption: Int
    var optionNumber: Int
    var systemIcon: String
    var content: () -> Content //Estructura para el contenido
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                
                selectedOption = optionNumber
            }
        }) {
            if selectedOption == optionNumber {
                Circle()//Navigation bar buttons
                    .fill(LinearGradient(gradient: Gradient(colors: [.buttonColor1, .buttonColor2]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 60, height: 60)
                    .overlay(Image(systemName: systemIcon)
                        .font(.system(size: 25))
                        .foregroundColor(.white))
            } else {
                Circle()
                    .fill(Color.offButtonColor)
                    .frame(width: 60, height: 60)
                    .overlay(Image(systemName: systemIcon).foregroundColor(.white)
                        .font(.system(size: 25)))
            }
        }
    }
}

// Modificador para la animación del radio
struct SelectionModifier: ViewModifier {
    var selected: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(selected ? 1.2 : 1.0)
            .animation(.spring())
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
