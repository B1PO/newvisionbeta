import SwiftUI

var width = UIScreen .main.bounds .width

//ESTA ES EL HOMEE
struct InfoFrameView: View {
    
    @EnvironmentObject var model: CarouselViewModel
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack{
                //Inicio del carousel
                ZStack{
                    ForEach (model.cards.indices.reversed(), id:
                                \.self){index in
                        
                        HStack {
                            //Lee el index de CardView
                            CardView (card: model.cards [index], animation: animation)
                                .frame (width: getCardWidth(index: index), height: getCardHeight(index: index))
                                //.cornerRadius(25)
                                .offset(x: getCardOffset (index: index))
                                .rotationEffect(.init(degrees:
                                getCardRotation (index: index)))
                            
                            Spacer (minLength: 0)
                        }
                        .frame (height: 400)
                        .contentShape (Rectangle())
                        .offset (x: model.cards[index].offset)
                        //Agregar animacion
                        .gesture (DragGesture (minimumDistance: 0)
                        .onChanged ({ (value) in
                                onChanged (value: value, index:
                                            index)
                            }) .onEnded({ (value) in
                                onEnd (value: value, index: index)
                            }))
                    }
                }
                .padding(.top,3) // cambiar el padding de arriba
                .padding (.horizontal,30)
                
                Button(action: ResetViews, label: {
                    Image (systemName: "arrow.left" )
                        .font (.system(size: 15, weight: .semibold))
                        .foregroundColor (.backgroundColor)
                        .padding ()
                        .background (Color.white)
                        .clipShape (Circle ())
                        .shadow (radius: 3)
                })
                .padding (.top, 0)
                
                Spacer()
            }
            
            //Detalle de cada carta/tarjeta
            if model.showCard{
                DetailView(animation: animation)
            }

        }
    }
    
    func ResetViews ( ){
        for index in model.cards.indices {
            withAnimation (.spring () ){
                model.cards [index].offset = 0
                //Regresar las cartas a su posicion
                model.swipedCard = 0
            }
        }
    }
    
    //Funciones para las animaciones
    func onChanged (value: DragGesture.Value, index: Int) {
        if value.translation.width < 0{
            model.cards[index].offset = value.translation.width
        }
    }
    
    func onEnd (value: DragGesture.Value, index: Int) {
        //Se guardan a la izquierda las cartas
        withAnimation{
            if -value.translation.width > width / 3{
                model.cards[index].offset = -width
                model.swipedCard += 1
            }
            else{
                model.cards[index].offset = 0
            }
        }
    }
    
    func getCardRotation (index: Int) ->Double{
        let boxwidth = Double (width / 3)
        let offset = Double (model.cards [index].offset)
        
        let angle : Double = 5
        
        return (offset / boxwidth) * angle
        
    }
    
    //Tamaño de las cartas
    func getCardHeight(index: Int)->CGFloat{
        let height: CGFloat = 400
        // Again First Three Cards..
        let cardHeight = index - model.swipedCard <= 2 ? CGFloat(index - model.swipedCard) * 35 : 70
        
        return height - cardHeight //largo de la carta
    }
    
    func getCardWidth(index: Int)->CGFloat{
        //sino 60-60 30 : 60
        let boxWidth = UIScreen.main.bounds.width - 60 - 60 //ancho
        //let cardWidth = index <= 2 ? CGFloat(index) * 30 : 60
        
        return boxWidth
    }
    
    func getCardOffset(index: Int)->CGFloat {
        return index - model.swipedCard <= 2 ? CGFloat (index - model.swipedCard) * 30 : 60
    }
}

struct InfoFrameView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
