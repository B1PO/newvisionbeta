import SwiftUI

struct MainSideView: View {
    
    @State var selectedTab = "Home"
    @State var showMenu = false
    
    var body: some View {
        ZStack {
            Color.slideMenuColor
            
            //Main Menu
            SideMenuView(selectedTab: $selectedTab)
            
            ZStack{
                Color.backgroundColor
                    .opacity (0.5)
                    .cornerRadius(showMenu ? 15:0)
                    .shadow(color: Color.white.opacity(0.07),radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -25 : 0)
                    .padding (.vertical, 30)
                
                Color.backgroundColor
                    .opacity (0.5)
                    .cornerRadius(showMenu ? 15:0)
                    .shadow(color: Color.white.opacity(0.07),radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -50 : 0)
                    .padding (.vertical, 60)
                
                HomeView(selectTab: $selectedTab)
                    .cornerRadius(showMenu ? 20 : 0)
            }
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect().width - 140 : 0)
            .ignoresSafeArea()
            
            .overlay(
                Button(action: {
                    withAnimation(.spring()){
                        showMenu.toggle()
                    }
                }, label: {
                    
                    // Animted Drawer Button..
                    VStack(spacing: 5){
                        Capsule ()
                            .fill (showMenu ? Color.white : Color.primary)
                            .frame (width: 30, height: 3)
                        // Rotating
                            .rotationEffect(.init(degrees: showMenu ? -50 : 0))
                            .offset(x:showMenu ? 2:0, y: showMenu ? 9:0)
                        
                        VStack(spacing: 5){
                            Capsule()
                                .fill (showMenu ? Color.white : Color.primary)
                                .frame (width: 30, height: 3)
                            //Moving Up when clicked.
                            Capsule ()
                                .fill (showMenu ? Color.white : Color.primary)
                                .frame (width: 30, height: 3) .offset (y: showMenu ? -8: 0)
                        }
                        .rotationEffect(.init(degrees:  showMenu ? 50:0))
                    }
                })
                .padding(EdgeInsets(top: 50, leading: 16, bottom: 150, trailing: 0))
                ,alignment: .topLeading
            )
        
        }.ignoresSafeArea()
    }
}

struct MainSideView_Previews: PreviewProvider {
    static var previews: some View {
        MainSideView()
    }
}

extension View{
    func getRect ()->CGRect {
        return UIScreen.main.bounds
    }
}

