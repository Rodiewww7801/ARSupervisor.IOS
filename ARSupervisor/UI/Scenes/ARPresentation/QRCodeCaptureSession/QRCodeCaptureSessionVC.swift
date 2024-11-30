//
//  QRCodeCaptureSessionVC.swift
//  ARSupervisor
//
//  Created by rodiewww7801_temp on 03.11.2024.
//

import UIKit
import Combine
@preconcurrency import AVFoundation


class QRCodeCaptureSessionVC: UIViewController, RouteProvider {
    var route: (any NavigationRoute)?
    //TODO: fix unsafe
    nonisolated(unsafe) let session: AVCaptureSession = AVCaptureSession()
    
    init(for route: any NavigationRoute) {
        self.route = route
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum Constants {
      static let alertTitle = "Scanning is not supported"
      static let alertMessage = "Your device does not support scanning a code from an item. Please use a device with a camera."
      static let alertButtonTitle = "OK"
    }
    
    override func loadView() {
        super.loadView()
        self.setupCamera()
    }
    
    private func setup() {
        setupCamera()
    }
    
    private func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            let output = AVCaptureMetadataOutput()
            
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            session.addInput(input)
            session.addOutput(output)
            
            output.metadataObjectTypes = [.qr]
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            
            view.layer.insertSublayer(previewLayer, at: 0)
            DispatchQueue.global().async {
                self.session.startRunning()
            }
        } catch {
            showAlert()
            print(error)
        }
    }
    
    func showAlert() {
            let alert = UIAlertController(title: Constants.alertTitle,
                                          message: Constants.alertMessage,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.alertButtonTitle,
                                          style: .default))
            present(alert, animated: true)
    }
}

extension QRCodeCaptureSessionVC: @preconcurrency AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {

        guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
                  metadataObject.type == .qr,
                  let stringValue = metadataObject.stringValue else { return }
        
        print(stringValue)
    }
}
