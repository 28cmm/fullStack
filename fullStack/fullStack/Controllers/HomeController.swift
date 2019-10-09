//
//  HomeController.swift
//  fullStack
//
//  Created by Yilei Huang on 2019-10-05.
//  Copyright © 2019 Joshua Fang. All rights reserved.
//

import LBTATools
import WebKit
import Alamofire
import JGProgressHUD
import SDWebImage

extension HomeController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let image = info[.originalImage] as? UIImage else {return}
            
            dismiss(animated: true){
                let createPostController = CreatePostVC(selectedImage: image)
                createPostController.homeController = self
                self.present(createPostController,animated: true)
//                let url = "http://localhost:1337/post"
//                Alamofire.upload(multipartFormData: { (formData) in
//                    formData.append(Data("Comming from uphone SIm".utf8), withName: "postBody")
//
//                    guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
//
//                    formData.append(imageData, withName: "imagefile",fileName: "Doesn't matter", mimeType: "image/jpg")
//                }, to: url) { (res) in
//
//                    switch res{
//                    case .failure(let err):
//                        print(err)
//                    case .success(let uploadRequest,_,_):
//                        uploadRequest.uploadProgress { (progress) in
//                            print("Upload progress: \(progress.fractionCompleted)")
//                        }
//
//                        uploadRequest.responseJSON { (dataResp) in
//                            if let err = dataResp.error {
//                                print("Failed to hit server:", err)
//                                return
//                            }
//
//                            if let code = dataResp.response?.statusCode, code >= 300 {
//                                print("Failed upload with status: ", code)
//                                return
//                            }
//
//                            let respString = String(data: dataResp.data ?? Data(), encoding: .utf8)
//                            print("Successfully created post, here is the response:")
//                            print(respString ?? "")
//
//                            self.fetchPosts()
//                        }
//                    }
//                    print("Maybe finished uploading")
//                }
//
            }
        }
  
}

class HomeController: UITableViewController {
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        showCookies()
        navigationItem.rightBarButtonItems = [
             .init(title: "fetch Posts", style: .plain, target: self, action: #selector(fetchPosts)),
              .init(title: "Create Posts", style: .plain, target: self, action: #selector(createPosts))
            ]
        
        navigationItem.leftBarButtonItem = .init(title: "Login", style: .plain, target: self, action: #selector(handleLogin))
        
    }
    
  
    
    @objc fileprivate func createPosts(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated:true)
    }
    fileprivate func showCookies(){
           HTTPCookieStorage.shared.cookies?.forEach({ (cookies) in
               print(cookies)
           })
       }
    @objc fileprivate func handleLogin(){
        let navControl = UINavigationController(rootViewController: LoginVC())
        present(navControl,animated: true)
    }
    
    @objc fileprivate func fetchPosts(){
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Fetch Posts"
        hud.show(in: view)
        Service.shared.fetchPosts { (res) in
            hud.dismiss()
            switch res{
            case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                
            case .failure(let err):
                print("failed to Fetch: ",err.localizedDescription)
            }
            
            
        }

               
               
              
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostCell(style: .subtitle, reuseIdentifier: nil)
        let post = posts[indexPath.row]
        cell.usernameLabel.text = post.user.fullName
        cell.postTextLabel.text = post.text
        cell.postImageView.sd_setImage(with: URL(string: post.imageUrl))
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
