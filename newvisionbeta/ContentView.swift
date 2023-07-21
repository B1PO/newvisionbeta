import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.gray
            VStack {
                Text("Prueba de Splash")
                    .foregroundColor(.yellow)
            }
            .padding()
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
