//
//  AddItemViewController.swift
//  Collector
//
//  Created by Ivaylo Yosifov on 30/4/18.
//  Copyright © 2018 Ivaylo Yosifov. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePeacker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePeacker.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let choosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            itemImageView.image = choosenImage
        }
        imagePeacker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePeacker.sourceType = .photoLibrary
        present(imagePeacker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePeacker.sourceType = .camera
        present(imagePeacker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let item = Item(entity: Item.entity(), insertInto: context)
            item.title = titleTextField.text
            if let image = itemImageView.image {
                if let imageData = UIImagePNGRepresentation(image) {
                    item.image = imageData
                }
            }
            try? context.save()
            navigationController?.popViewController(animated: true)
        }
    }
    
    
}
