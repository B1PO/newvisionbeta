import SwiftUI

struct DetailView: View {
    @EnvironmentObject var model: CarouselViewModel
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            VStack{
                //Contenido de las cartas extendida
                Text ("Objects")
                    .font (.caption)
                    .foregroundColor (Color.white.opacity (0.85))
                    .frame (maxWidth: .infinity, alignment: .leading)
                    .padding ()
                    .padding (.top, 10)
                    .matchedGeometryEffect(id: "Date-\(model.selectedCard.id)", in:
                                            animation)
                    
                HStack {
                    Text (model.selectedCard.title)
                        .font (.title)
                        .fontWeight (.bold)
                        .foregroundColor (.white)
                        .frame (width: 250, alignment: .leading) .padding ( )
                        .matchedGeometryEffect (id: "Title-\(model.selectedCard.id)", in:
                                                    animation)
                        .padding (.top, -20)
                    
                    Spacer (minLength: 0)
                }
                
                //Contenido del detalle de las cartas 17:58
                if model.showContent {
                    Text (model.content)
                        .fontWeight(.semibold)
                        .foregroundColor (.white)
                        .padding ()
                }
                
                Spacer (minLength: 0)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            model.selectedCard.cardColor
                .frame(width: 375, height: 476) //Tamaño del detalle
                .cornerRadius (25)
                .matchedGeometryEffect(id: "bColor-\(model.selectedCard.id)", in: animation) .ignoresSafeArea(.all, edges: .bottom)
                .offset(x: 0, y: -137)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
            )
            

        }//fin del zstac
        
        //Boton para cerrar el detalle de la carta
        VStack{
            Spacer ()
            if model.showContent {
                Button (action: CloseView, label: {
                    Image (systemName: "x.circle.fill" ) //si se ve feo regresar a la felcha y a 15 "arrow.down"
                        .font (.system(size: 25, weight: .semibold)).foregroundColor (.white)
                        .padding ()
                        //.background (Color.white.opacity (0.6))
                        //.clipShape (Circle())
                        //.padding (5)
                        //.background (Color.white.opacity (0.7))
                        //.clipShape (Circle ())
                        .shadow (radius: 3)
                })
                .padding(.bottom, 270)
            }
        }
    }
    
    func CloseView(){
        withAnimation(.easeInOut(duration: 0.01)){
            model.showCard.toggle()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
