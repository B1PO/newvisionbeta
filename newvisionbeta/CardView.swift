
import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var model : CarouselViewModel
    var card: Card
    var animation: Namespace.ID
    
    var body: some View {
        VStack{
            Text ("Objects")
                .font (.caption)
                .foregroundColor (Color.white.opacity (0.85))
                .frame (maxWidth: .infinity, alignment: .leading)
                .padding ()
                .padding (.top, 10)
                .matchedGeometryEffect(id: "Date-\(card.id)", in: animation)
            
            HStack {
                Text (card.title)
                    .font (.title)
                    .fontWeight (.bold)
                    .foregroundColor (.white)
                    .frame (width: 250, alignment: .leading) .padding ( )
                    .matchedGeometryEffect (id: "Title-\(card.id)", in:
                    animation)
                Spacer (minLength: 0)
                
                
            }
            
            Spacer (minLength: 0)
            
            HStack{
                Spacer (minLength: 0)
                
                if !model.showContent{
                    Text ("Read More")
                    Image (systemName: "arrow.right")
                }
            }
            .foregroundColor (Color.white.opacity (0.9))
            .padding(29)
        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background (card .cardColor
            .cornerRadius(25)
            .matchedGeometryEffect(id: "bColor-\(card.id)", in:
            animation)
        )
        //.cornerRadius (25)
        .onTapGesture {
            withAnimation(.spring(blendDuration: 1.0)) { //CAMBIAR ANIMACION
                model.selectedCard = card
                model.showCard.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now () + 0.3) {
                    withAnimation(.easeIn) {
                        model.showContent = true
                    }
                }
            }
            //.animation(.easeInOut(duration: 1.0))
        }
        .transition(.opacity)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
