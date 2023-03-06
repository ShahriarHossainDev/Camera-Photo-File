//
//  CameraViewController.swift
//  Camera Photo File
//
//  Created by Shishir_Mac on 6/3/23.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picImageView.dropShadow()
        cameraButton.dropShadow()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        picImageView.image = image
    }
}
