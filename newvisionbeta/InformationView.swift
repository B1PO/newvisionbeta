//
//  InformationView.swift
//  newvisionbeta
//
//  Created by Emilia Zuñiga Losada on 24/07/23.
//

import SwiftUI

struct InformationView: View {
    
    @StateObject var homeModel = CarouselViewModel ()
    
    var body: some View {
        InfoFrameView()
            .environmentObject (homeModel)
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
