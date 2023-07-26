import SwiftUI
import AVFoundation

struct CameraView: View {
    
    var body: some View {
        CameraServiceView()
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}

struct CameraServiceView: View {
    
    @StateObject var camera = CameraModel ()
    
    var body: some View{
        ZStack{
            //Going to Be Camera preview...
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack{
                if camera.isTaken{
                    HStack{
                        Spacer()
                        Button(action: {}, label: {
                            Image (systemName: "arrow.triangle.2.circlepath.camera")
                            .foregroundColor(.white)
                            .padding ()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.buttonColor1, Color.buttonColor2]), startPoint: .leading, endPoint: .trailing)
                                )
                            .clipShape (Circle () )
                        })
                        .padding (.trailing,10)
                    }
                }

                Spacer ()
                HStack{
                    //Si se mantiene presionado
                    if camera.isTaken{
                        Button(action: {}, label: {
                            Text ("Process")
                                .foregroundColor (.frameColor)
                                .fontWeight (.semibold)
                                .padding (.vertical, 10)
                                .padding(.horizontal,20)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.buttonColor1, Color.buttonColor2]), startPoint: .leading, endPoint: .trailing)
                                )
                                .clipShape (Capsule () )
                        })
                        .padding (.leading)
                        Spacer ()
                            
                    }else{
                        Button(action: {camera.isTaken.toggle()}, label: {
                            ZStack{
                                Circle()
                                    .fill(Color.white)
                                    . frame (width: 65, height: 65)
                                
                                Circle()
                                    .stroke (Color.white, lineWidth: 2)
                                    .frame (width: 75, height: 75)
                            }
                        })
                    }
                }
                .frame (height: 75)
            }
        }
        .onAppear (perform: {
            camera.Check()
        })
    }
}
           
//Camara Model
class CameraModel: ObservableObject{
    @Published var isTaken = false
    @Published var session = AVCaptureSession ()
    @Published var alert = false
    
    @Published var output = AVCapturePhotoOutput()
    
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    func Check(){
        // first checking camerahas got permission...
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUP()
            return
            // Setting Up Session default:
        case .notDetermined:
            AVCaptureDevice.requestAccess (for: .video) { (status) in
                if status{
                    self.setUP()
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUP(){
        do{
            // setting configs...
            self.session.beginConfiguration ()
            // change for your own..
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            
            let input = try AVCaptureDeviceInput (device: device!)
            
            if self.session.canAddInput (input) {
                self.session.addInput (input)
            }
            
            if self.session.canAddOutput (self.output) {
                self.session.addOutput (self.output)
            }
            
            self.session.commitConfiguration()
            
        }catch{
            print (error.localizedDescription)
        }
        
    }
}

struct CameraPreview: UIViewRepresentable {

@ObservedObject var camera: CameraModel

    func makeUIView(context: Context) -> UIView {
        
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer (session: camera.session)
        camera.preview.frame = view.frame

        camera.preview.videoGravity = .resizeAspectFill

        view.layer.addSublayer(camera.preview)
        
        camera.session.startRunning ()
        return view
    }
    
    func updateUIView(_ uiview: UIView, context: Context){
    }
}

