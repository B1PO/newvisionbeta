import SwiftUI

struct UploadImageView: View {
    @State private var selectedImage: Image?
    @State private var isImagePickerPresented = false

    var body: some View {
        VStack {
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            } else {
                Text("No Image Selected")
                    .foregroundColor(.gray)
                    .padding()
            }

            Button("Upload Image") {
                isImagePickerPresented.toggle()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
        .navigationBarTitle("Image Upload")
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: Image?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: uiImage)
            }
            picker.dismiss(animated: true)
        }
    }
}

struct UploadImageView_Previews: PreviewProvider {
    static var previews: some View {
        UploadImageView()
    }
}

