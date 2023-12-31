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
                        Button(action: {camera.reTake()}, label: {
                            Image (systemName: "arrow.triangle.2.circlepath.camera")
                            .foregroundColor(.white)
                            .padding ()
                            .background(.white)
                            .clipShape (Circle () )
                        })
                        .padding (.trailing,10)
                    }
                }

                Spacer ()
                HStack{
                    //Si se mantiene presionado
                    if camera.isTaken{
                        Button(action: {if !camera.isSaved{camera.savePic()}}, label: {
                       
                            Text (camera.isSaved ? "Saved" :
                        "Process")
                                .foregroundColor (.frameColor)
                                .fontWeight (.semibold)
                                .padding (.vertical, 65)
                                .padding(.horizontal,20)
                                .background(.white)
                                .clipShape (Capsule () )
                        })
                        .padding (.leading)
                        Spacer ()
                            
                    }else{
                        Button(action: camera.takePic, label: {
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
class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    @Published var isTaken = false
    @Published var session = AVCaptureSession ()
    @Published var alert = false
    
    @Published var output = AVCapturePhotoOutput()
    
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    // Pic Data...
    @Published var isSaved = false
    @Published var picData = Data (count: 0)
    
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
    
    func takePic() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning ()
            
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
            }
        }
    }
    
    func reTake (){
        DispatchQueue.global (qos: .background) .async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
            }
             //Limpiar al volver a tomar la foto
            self.isSaved = false
        }
    }
    
    func photoOutput (_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?){
        if error != nil{
            return
        }
        print ("pic taken...")
        
        guard let imageData = photo.fileDataRepresentation () else{return}
        self.picData = imageData
    }
    
    func savePic () {
        let image = UIImage (data: self.picData)!
        // saving Image...
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        self.isSaved = true
        
        print ("saved Success fully")
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

