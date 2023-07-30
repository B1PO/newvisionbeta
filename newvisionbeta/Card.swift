//
//  Card.swift
//  newvisionbeta
//
//  Created by Emilia Zuñiga Losada on 26/07/23.
//

import SwiftUI

//Model card
struct Card: Identifiable {
    var id = UUID() . uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    var title: String
    var icono: String
}
