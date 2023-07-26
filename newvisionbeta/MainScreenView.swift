import SwiftUI

struct MainScreenView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea(.all)
            
            VStack(spacing: 2) {
                ForEach(0..<Int(UIScreen.main.bounds.height / 20)) { _ in
                    RowOfDots(width: UIScreen.main.bounds.width, isAnimating: isAnimating)
                        .animation(.easeInOut(duration: Double.random(in: 1.0...2.0)))
                        .offset(x: isAnimating ? -UIScreen.main.bounds.width : 0)
                }
            }
            .padding(.horizontal, 20)
            
            if isAnimating {
                FloatingText(isAnimating: isAnimating)
                    .animation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true))
            }
        }
        .onAppear {
            startAnimation()
        }
        .navigationBarHidden(true)
    }
    
    private func startAnimation() {
        withAnimation(Animation.linear(duration: 4.0).repeatForever(autoreverses: true)) {
            isAnimating.toggle()
        }
        
        // Detenemos el movimiento temporalmente después de 5 segundos
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            stopAnimating()
        }
    }
    
    private func stopAnimating() {
        isAnimating.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            isAnimating.toggle()
        }
    }
}

struct RowOfDots: View {
    var width: CGFloat
    var isAnimating: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<5) { _ in
                DotView(isAnimating: isAnimating)
            }
        }
    }
}

struct DotView: View {
    @State private var scale: CGFloat = 1.0
    var isAnimating: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.buttonColor1.opacity(0.4))
                .frame(width: 16, height: 16)
                .scaleEffect(isAnimating ? scale : 1.0)
                .animation(Animation.easeInOut(duration: Double.random(in: 1.0...2.0)).repeatForever(autoreverses: true))
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true).delay(Double.random(in: 0.0...1.0))) {
                        scale = 0.5 // Ajustamos la escala inicial para el efecto de parpadeo
                    }
                }
        }
    }
}

struct FloatingText: View {
    var isAnimating: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("N")
                .offset(x: isAnimating ? randomOffset() : 0, y: isAnimating ? randomOffset() : 0)
            Text("E")
                .offset(x: isAnimating ? randomOffset() : 0, y: isAnimating ? randomOffset() : 0)
            Text("W")
                .offset(x: isAnimating ? randomOffset() : 0, y: isAnimating ? randomOffset() : 0)
            Text("V")
                .padding(.top, 20)
                .offset(x: isAnimating ? randomOffset() : 0, y: isAnimating ? randomOffset() : 0)
            Text("I")
                .offset(x: isAnimating ? randomOffset() : 0, y: isAnimating ? randomOffset() : 0)
            Text("S")
                .offset(x: isAnimating ? randomOffset() : 0, y: isAnimating ? randomOffset() : 0)
            Text("I")
                .offset(x: isAnimating ? randomOffset() : 0, y: isAnimating ? randomOffset() : 0)
            Text("O")
                .offset(x: isAnimating ? randomOffset() : 0, y: isAnimating ? randomOffset() : 0)
            Text("N")
                .offset(x: isAnimating ? randomOffset() : 0, y: isAnimating ? randomOffset() : 0)
        }
        .font(.system(size: 30, weight: .bold, design: .default))
        .foregroundColor(.buttonColor1)
    }
    
    private func randomOffset() -> CGFloat {
        return CGFloat.random(in: -5...5)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}

