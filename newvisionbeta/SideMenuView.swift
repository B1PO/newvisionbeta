//
//  SlideMenuView.swift
//  newvisionbeta
//
//  Created by Emilia Zuñiga Losada on 21/07/23.
//

import SwiftUI

struct SideMenuView: View {
    
    @Binding var selectedTab: String
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70,height: 70)
                .cornerRadius(10)
                .padding(.top, 80) //Espacio para selec. opcion
            
            VStack(alignment: .leading, spacing: 6, content:{
                Text("New Vision")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            })
            
            VStack(alignment: .leading, spacing: 10) {
                TabButtonView(image: "house.fill", title: "Home", selectTab: $selectedTab, animation: animation)
                
                TabButtonView(image: "square.fill.on.circle.fill", title: "Objects", selectTab: $selectedTab, animation: animation)
                
                TabButtonView(image: "pencil.and.outline", title: "Strokes", selectTab: $selectedTab, animation: animation)
                
                TabButtonView(image: "face.dashed.fill", title: "Emotions", selectTab: $selectedTab, animation: animation)
            }
            .padding(.leading, -15)
            .padding(.top, 50)
            
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
    }
}

//MainView TabButton CustomCorners
struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenview()
    }
}

