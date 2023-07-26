import SwiftUI

struct MainScreenView: View {
    var body: some View {
        LetterNShape()
    }
}

struct LetterNShape: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 30, height: 100)
                .cornerRadius(10)
            
            Rectangle()
                .fill(Color.blue)
                .frame(width: 30, height: 100)
                .cornerRadius(10)
                .rotationEffect(.degrees(-45)) // Rotación para formar la letra "N"
                .offset(x: 35, y: 0) // Ajustamos la posición para que se alinee correctamente
            
            Rectangle()
                .fill(Color.blue)
                .frame(width: 30, height: 100)
                .cornerRadius(10)
                .offset(x: 70)
            
            Rectangle()
                .fill(Color.blue)
                .frame(width: 30, height: 100)
                .cornerRadius(10)
                .rotationEffect(.degrees(-45)) // Rotación para formar la letra "N"
                .offset(x: 35, y: 0) // Ajustamos la posición para que se alinee correctamente
            
            Rectangle()
                .fill(Color.blue)
                .frame(width: 30, height: 100)
                .cornerRadius(10)
                .offset(x: 70)
            
            
        }
    }
}


struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}

