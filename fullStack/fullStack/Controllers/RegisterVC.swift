//
//  RegisterVC.swift
//  fullStack
//
//  Created by Yilei Huang on 2019-10-07.
//  Copyright © 2019 Joshua Fang. All rights reserved.
//

import LBTATools
import JGProgressHUD
import Alamofire

class RegisterVC: LBTAFormController {
    
    //MARK: UI Element
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "startup"), contentMode: .scaleAspectFit)
    let logoLabel = UILabel(text: "FullStack Social", font: .systemFont(ofSize: 32, weight: .heavy), textColor: .black, numberOfLines: 0)
    
    let fullNameTextField = IndentedTextField(placeholder: "Full Name", padding: 24, cornerRadius: 25)
    let emailTextField = IndentedTextField(placeholder: "Email", padding: 24, cornerRadius: 25)
    let passwordTextField = IndentedTextField(placeholder: "Password", padding: 24, cornerRadius: 25, isSecureTextEntry: true)
    lazy var signUpButton = UIButton(title: "Sign Up", titleColor: .white, font: .boldSystemFont(ofSize: 18), backgroundColor: .black, target: self, action: #selector(handleSignup))
    
    let errorLabel = UILabel(text: "Something went wrong during sign up, please try again later.", font: .systemFont(ofSize: 14), textColor: .red, textAlignment: .center, numberOfLines: 0)
    
    lazy var goBackButton = UIButton(title: "Go back to login.", titleColor: .black, font: .systemFont(ofSize: 16), target: self, action: #selector(goToRegister))

    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.isHidden = true
        emailTextField.autocapitalizationType = .none
        [fullNameTextField, emailTextField, passwordTextField].forEach{$0.backgroundColor = .white}
        signUpButton.layer.cornerRadius = 25

        view.backgroundColor = .init(white: 0.92, alpha: 1)
        
        let formView = UIView()
        formView.stack(
            formView.stack(
                formView.hstack(logoImageView.withSize(.init(width: 80, height: 80)),logoLabel.withWidth(160),spacing:16).padLeft(12).padRight(12),alignment:.center
            ),
            UIView().withHeight(12),
            fullNameTextField.withHeight(50),
            emailTextField.withHeight(50),
            passwordTextField.withHeight(50),
            errorLabel,
            signUpButton.withHeight(50),
            goBackButton.withHeight(50),
            spacing:16
        ).withMargins(.init(top: 48, left: 32, bottom: 0, right: 32))
        formContainerStackView.addArrangedSubview(formView)
    }
    
    @objc fileprivate func handleSignup(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Registering"
        hud.show(in: view)
        
        guard let fullName = fullNameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Service.shared.signUp(fullName: fullName, emailAddress: email, password: password) { (res) in
            
            hud.dismiss(animated: true)
            
            switch res {
            case .failure(let err):
                print("Failed to sign up:", err)
                self.errorLabel.isHidden = false
            case .success:
                print("Successfully signed up")
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc fileprivate func goToRegister(){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
