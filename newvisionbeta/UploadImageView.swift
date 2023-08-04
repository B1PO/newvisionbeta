import SwiftUI

struct UploadImageView: View {
    
    @State var selectedImage = UIImage()
    @State var isImagePickerShown = false
    @StateObject var model = ObjectClassifierModel()
    
    var body: some View {
        VStack {
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(15.0)
                .shadow(color: .offButtonColor, radius: 3)
                .padding()
            
            Text(model.resultText)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
            
            Spacer()
            Button {
                isImagePickerShown = true
            } label: {
                Label("Select New Image", systemImage: "photo.fill")
                    .padding()
            }
        }
        .onAppear {
            if let image = UIImage(named: "dog") {
                self.selectedImage = image
                model.classifyImage(image)
            }
        }
        .imagePickerSheet(isPresented: $isImagePickerShown) { image in
            self.selectedImage = image
            model.classifyImage(image)
        }
    }
}

struct UploadImageView_Previews: PreviewProvider {
    static var previews: some View {
        UploadImageView()
    }
}

