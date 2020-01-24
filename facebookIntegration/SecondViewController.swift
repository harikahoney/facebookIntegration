//
//  SecondViewController.swift
//  facebookIntegration
//
//  Created by Sagi Harika on 22/01/20.
//  Copyright © 2020 Sagi Harika. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare
class SecondViewController: UIViewController,SharingDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        print("share success")
    }
    
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        print("share fail")
    }
    
    func sharerDidCancel(_ sharer: Sharing) {
        print("share cancel")
    }
    
   let imagePickerController = UIImagePickerController()
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let graphReq = GraphRequest(graphPath: "/me", parameters: ["fields" :"name,picture.width(400)"], tokenString: AccessToken.current?.tokenString, version: Settings.defaultGraphAPIVersion, httpMethod: .get)
        let graphConn = GraphRequestConnection()

        graphConn.add(graphReq) { (connectionDetails, value, err) in
            if let data = value as? [String:Any]
            {
                let name = data["name"] as! String
                let pictureDict = data["picture"] as! [String:Any]
                let imageDict = pictureDict["data"] as! [String:Any]
                let imageUrl = imageDict["url"] as! String
                print(name)
                do{
                    let image = URL(string: imageUrl)
                    
                    
                    self.profileImg.image =  UIImage(data: try Data(contentsOf: image!))
                    
                    
                    self.userName.text = name
                    
                    
                }catch{
                    
                    print("not gett")
                }
                print(name)
            }
        }
        graphConn.start()
    }

    
    
    @IBAction func shareLinkBtn(_ sender: Any) {
        
        let content = ShareLinkContent()
        content.contentURL = URL(string: "https://newsroom.fb.com/")!
        content.quote = "hai"
        
        
        let shareDialog = ShareDialog(fromViewController: self, content: content, delegate: self as! SharingDelegate)
        
        shareDialog.mode = .automatic
        shareDialog.show()
        
    }
    
    @IBAction func sharePicBtn(_ sender: Any) {
        imagePickerController.delegate = self
                     imagePickerController.sourceType = .photoLibrary
              imagePickerController.mediaTypes = ["public.image"]
                      
                     present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func shareVideoBtn(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            // Use editedImage Here
//            
//        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            // Use originalImage Here
//            dismiss(animated: true){
//                // if app is available
//                if UIApplication.shared.canOpenURL(URL(string: "fb://")!){
//                    let photo = SharePhoto(image: originalImage, userGenerated: true)
//                    let content = SharePhotoContent()
//                    
//                    content.photos = [photo]
//                    
//                    let shareDialog = ShareDialog(fromViewController: self, content: content, delegate: self)
//                    
//                    shareDialog.mode = .automatic
//                    shareDialog.show()
//
//                }else {
//                    print("app not installed")
//                    //                    UIApplication.shared.open(URL(string: "itms://itunes.apple.com/in/app/facebook/id284882215")!, options: [ : ], completionHandler: nil)
//                }
//            }
//        }
//            
//        else if let videoURL = info[UIImagePickerController.InfoKey.referenceURL] as? URL {
//            picker.dismiss(animated: true){
//                // if app is available
//                if UIApplication.shared.canOpenURL(URL(string: "fb://")!){
//                    let video = ShareVideo(videoURL: videoURL)
//                    let myContent = ShareVideoContent()
//                    
//                    myContent.video = video
//                    let shareDialog = ShareDialog(fromViewController: self, content: myContent, delegate: self)
//                    
//                    shareDialog.mode = .automatic
//                    shareDialog.show()
//                }else {
//                    print("app not installed")
//                    //                  UIApplication.shared.open(URL(string: "itms://itunes.apple.com/in/app/facebook/id284882215")!, options: [ : ], completionHandler: nil)
//                }
//            }
//        }
//        
//        
//    }
//    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
