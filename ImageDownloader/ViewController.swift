//
//  ViewController.swift
//  ImageDownloader
//
//  Created by Ravi Gelani on 2023-11-14.
//

import UIKit

class ViewController: UIViewController, NewImageDelegate {
    
    
    func imageDidAddCorrectly(newImage: ImageData) {
        imageList.append(newImage)
        pickerVIew.reloadAllComponents()
        if(imageList.count == 1){
            DispatchQueue.main.async {
                if let imageData = self.imageList[0].imageURL, let bgImage = UIImage(data: imageData) {
                    self.ivImages.image = bgImage
                }
            }
        }
    }
    
    func viewDidCancel() {
      print("Something went wrong")
    }
    

    @IBOutlet weak var ivImages: UIImageView!
    
    @IBOutlet weak var pickerVIew: UIPickerView!
    
    var imageList = (UIApplication.shared.delegate as! AppDelegate).allImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerVIew.delegate = self
        pickerVIew.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as! ImageURLViewController
        des.delegate = self
    }
}



extension ViewController : UIPickerViewDelegate {
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    let name = imageList[row].imageName
    return  name
}

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(imageList.count > 0){
            DispatchQueue.main.async {
                if let imageData = self.imageList[row].imageURL, let bgImage = UIImage(data: imageData) {
                    self.ivImages.image = bgImage
                }
            }
        }
    }
}

extension ViewController : UIPickerViewDataSource {
func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}

func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
   return imageList.count
}
}
