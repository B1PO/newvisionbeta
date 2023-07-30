import SwiftUI

struct MainScreenView: View {
    @State private var isAnimating = false
    @State private var gradientRotation: Double = 0.0

    var body: some View {

        ZStack {
            Color.slideMenuColor
                .ignoresSafeArea(.all)
            VStack{
                Text("N")
                    .foregroundColor(.offButtonColor)
                    .font(.custom("Impact", size: 60))
                Text("E")
                    .font(.custom("Impact", fixedSize: 60))
                    .foregroundColor(.offButtonColor)
                Text("W")
                    .font(.custom("Impact", fixedSize: 55))
                    .foregroundColor(.offButtonColor)
                    .padding(.bottom, 20)
                Text("V")
                    .foregroundColor(.offButtonColor)
                    .font(.custom("Impact", fixedSize: 40))
                Text("I")
                    .foregroundColor(.offButtonColor)
                    .font(.custom("Impact", fixedSize: 40))
                Text("S")
                    .foregroundColor(.offButtonColor)
                    .font(.custom("Impact", fixedSize: 40))
                Text("I")
                    .foregroundColor(.offButtonColor)
                    .font(.custom("Impact", fixedSize: 40))
                Text("O")
                    .foregroundColor(.offButtonColor)
                    .font(.custom("Impact", fixedSize: 40))
                Text("N")
                    .foregroundColor(.offButtonColor)
                    .font(.custom("Impact", fixedSize: 40))

            }
            .padding(.leading,250)
            VStack {
                Spacer()
                Button(action: {

                }) {

                    HStack {
                        Text("START")
                            .foregroundColor(.white)
                            .bold()

                        Image(systemName: "play")
                            .bold()
                            .font(.callout)

                        .foregroundColor(.white)
                    }

                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .strokeBorder(
                            AngularGradient(gradient: Gradient(colors: [Color.buttonColor1, Color.white]), center: .center, angle: .degrees(gradientRotation)),
                            lineWidth: 5
                        )
                        .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
                        .onAppear {
                            gradientRotation = 360.0
                        }
                )


                Spacer()
            }
            .padding(.top,650)
            .padding(.leading,250)
            VStack(spacing: 2) {
                ForEach(0..<Int(UIScreen.main.bounds.height / 20)) { _ in
                    RowOfDots(width: UIScreen.main.bounds.width, isAnimating: isAnimating)
                        .animation(.easeInOut(duration: Double.random(in: 1.0...2.0)))
                        .offset(x: isAnimating ? -UIScreen.main.bounds.width : 0)
                }
            }
            .padding(.horizontal, 20)
        }
        .statusBar(hidden: true)
        .onAppear {
            startAnimation()
        }
        .navigationBarHidden(true)
    }

    private func startAnimation() {
        withAnimation(Animation.linear(duration: 0.0).repeatForever(autoreverses: true)) {
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

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}



