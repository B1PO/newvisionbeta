import SwiftUI

struct HomeView: View {
    
    @Binding var selectedTab: String
    
    init(selectTab: Binding<String>) {
        self._selectedTab = selectTab
        UITableView.appearance().isHidden = true
    }
    var body: some View {
        TabView(selection: $selectedTab){
            HomePage()
                .tag("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainSideView()
    }
}

struct HomePage: View {
    var body: some View {
        //Color.blue.ignoresSafeArea()
        NavigationView {
            NavigationBarView()
                .padding(.bottom, -25)
        }
    }
}

