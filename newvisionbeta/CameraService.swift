//
//  CameraService.swift
//  newvisionbeta
//
//  Created by Emilia Zuñiga Losada on 24/07/23.
//

import Foundation
import AVFoundation

class CameraSevice {
    var session: AVCaptureSession?
    var delegate: AVCapturePhotoCaptureDelegate?
    let output = AVCapturePhotoOutput ()
    
    let previewLaver = AVCaptureVideoPreviewLayer()
    func start(delegate: AVCapturePhotoCaptureDelegate, completion: @escaping
               (Error?) -> ()) {
        self.delegate = delegate
    }
}
