import SwiftUI

struct TabButtonView: View {
    var image: String
    var title: String
    
    //Selected tab
    @Binding var selectTab: String
    //Animation
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            //Add motion/transition between options
            withAnimation(.spring()){selectTab = title}
            
        }, label: {
            HStack(spacing: 15){
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectTab == title ? Color.backgroundColor : .white)
            .padding(.vertical,10)
            .padding(.horizontal,10)
            
            .frame(maxWidth: getRect().width - 170, alignment: .leading)
            
            .background(
                ZStack{
                    if selectTab == title{
                        LinearGradient(gradient: Gradient(colors: [Color.buttonColor1, Color.buttonColor2]), startPoint: .leading, endPoint: .trailing)
                            .opacity(selectTab == title ? 1 : 0)
                            .clipShape(CustomCornersView(corners: [.topRight,.bottomRight], radius: 12))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
        })
    }
}

struct TabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainSideView()
    }
}

