import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Home"
    
    var body: some View {
        //HomeView(selectTab: $selectedTab) // Llamando a la vista HomeView
        //HomeP()
        MainSideView()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
