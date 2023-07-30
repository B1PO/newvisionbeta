//
//  CarouselViewModel.swift
//  newvisionbeta
//
//  Created by Emilia Zuñiga Losada on 26/07/23.
//

import SwiftUI

class CarouselViewModel: ObservableObject {
    
    @Published var cards = [
        Card (cardColor: Color.buttonColor1, title: "Object recognition operation", icono: "h"),
        Card (cardColor: Color.buttonColor2, title: "Brush up on hygine.", icono: "f"),
        Card (cardColor: Color.backgroundColor, title: "Don't skip breakfast.", icono: "ff"),
//        Card (cardColor: Color.yellow, title: "Brush up on hygine."),
//        Card (cardColor: Color.orange, title: "Neurobics for your mind."),
    ]
    
    @Published var swipedCard = 0
    
    @Published var showCard = false
    @Published var selectedCard = Card (cardColor: .clear, title: "", icono: "d")
    @Published var showContent = false
    
    var content = "Este es el contenido de la primer carta (el detalle)"
}
