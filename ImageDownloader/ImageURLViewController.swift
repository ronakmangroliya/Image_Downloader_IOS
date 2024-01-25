//
//  ImageURLViewController.swift
//  ImageDownloader
//
//  Created by Ravi Gelani on 2023-11-14.
//

import UIKit


protocol NewImageDelegate {
    func imageDidAddCorrectly(newImage : ImageData)
    func viewDidCancel()
}

class ImageURLViewController: UIViewController {

    
    @IBOutlet weak var etImageName: UITextField!
    
    @IBOutlet weak var etUrl: UITextField!
   
    var delegate : NewImageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnAdd(_ sender: Any) {
        if let name = etImageName.text {
            if let image = etUrl.text {
                if !name.isEmpty && !image.isEmpty {
                    downloadImage(nameofImage: name ,url: image)
                }
            }else {
                showAlert(title:"Failed",message:"Please enter image url")
            }
        }else {
            showAlert(title:"Failed",message:"Please enter name")
        }
    }
    
    func downloadImage(nameofImage: String, url: String) {
        let queue = DispatchQueue(label: "myq")
        queue.async {
            do {
                guard let urlObj = try? URL(string: url) else {
                    DispatchQueue.main.async {
                        self.showAlert(title:"Failed",message:"Invalid URL")
                    }
                    print("Invalid URL")
                    return
                }

                let imageData: Data = try Data(contentsOf: urlObj)

                let newImage = ImageData(imageName: nameofImage)
                newImage.imageURL = imageData
                DispatchQueue.main.async {
                    
                    self.delegate?.imageDidAddCorrectly(newImage: newImage)
                    self.dismiss(animated: true, completion: nil)
                }
            } catch {
                DispatchQueue.main.async {
                self.showAlert(title:"Something went wrong",message:"\(error)")
                }
                print("Something went wrong: \(error)")
            }
        }
    }


    @IBAction func btnCancel(_ sender: Any) {
       delegate!.viewDidCancel()
        dismiss(animated: true)
    }
    
    func showAlert(title : String , message : String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
