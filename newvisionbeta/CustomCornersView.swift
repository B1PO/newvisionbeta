//
//  CustomCornersView.swift
//  newvisionbeta
//
//  Created by Emilia Zuñiga Losada on 21/07/23.
//

import SwiftUI

struct CustomCornersView: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path (in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

