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
                FloatingText()
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
    @State private var isWhite = false
    
    var isAnimating: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isWhite ? Color.white : Color.buttonColor1.opacity(0.4))
                .frame(width: 16, height: 16)
                .scaleEffect(isAnimating ? scale : 1.0)
                .animation(Animation.easeInOut(duration: Double.random(in: 1.0...2.0)).repeatForever(autoreverses: true))
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true).delay(Double.random(in: 0.0...1.0))) {
                        scale = 0.5 // Ajustamos la escala inicial para el efecto de parpadeo
                    }
                    withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true).delay(Double.random(in: 0.0...1.0))) {
                        isWhite.toggle()
                    }
                }
        }
    }
}

struct FloatingText: View {
    @State private var isWhite = true
    
    var body: some View {
        VStack(spacing: 20) {
            Text("N")
                .foregroundColor(isWhite ? Color.white : Color.black)
                .offset(x: randomOffset(), y: randomOffset())
            Text("E")
                .foregroundColor(isWhite ? Color.white : Color.black)
                .offset(x: randomOffset(), y: randomOffset())
            Text("W")
                .foregroundColor(isWhite ? Color.white : Color.black)
                .offset(x: randomOffset(), y: randomOffset())
            Text("V")
                .padding(.top, 20)
                .foregroundColor(isWhite ? Color.white : Color.black)
                .offset(x: randomOffset(), y: randomOffset())
            Text("I")
                .foregroundColor(isWhite ? Color.white : Color.black)
                .offset(x: randomOffset(), y: randomOffset())
            Text("S")
                .foregroundColor(isWhite ? Color.white : Color.black)
                .offset(x: randomOffset(), y: randomOffset())
            Text("I")
                .foregroundColor(isWhite ? Color.white : Color.black)
                .offset(x: randomOffset(), y: randomOffset())
            Text("O")
                .foregroundColor(isWhite ? Color.white : Color.black)
                .offset(x: randomOffset(), y: randomOffset())
            Text("N")
                .foregroundColor(isWhite ? Color.white : Color.black)
                .offset(x: randomOffset(), y: randomOffset())
        }
        .font(.system(size: 30, weight: .bold, design: .default))
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

