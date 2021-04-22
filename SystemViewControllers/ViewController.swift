//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Алексей Сергеев on 21.04.2021.
//  Copyright © 2021 Алексей Сергеев. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func shareButton(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//        activityController.popoverPresentationController?.sourceView = sender
//
        present(activityController, animated: true, completion: nil)
        
    }
    
    @IBAction func safariButton(_ sender: UIButton) {
        if let safariLink = URL(string: "www.apple.com") {
            let safariViewController = SFSafariViewController(url: safariLink)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        
        // create instance of image picker and delegate
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // create alert controller
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        // Photo Library Action
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction  = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        // Camera action
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        // cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = sender

        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func emailButton(_ sender: UIButton) {
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail could not be transmitted")
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        mailComposer.setToRecipients(["example@example.example"])
        mailComposer.setSubject("Test")
        mailComposer.setMessageBody("It is the test. If you recive it, you will better answer us. Over", isHTML: false)
        
        if let image = imageView.image, let jpegData = image.jpegData(compressionQuality: 0.8) {
            mailComposer.addAttachmentData(jpegData, mimeType: "image/jpeg", fileName: "some_image.jpeg")
        }
        
        present(mailComposer, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }

}

