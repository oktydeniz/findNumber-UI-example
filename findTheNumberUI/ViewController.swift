//
//  ViewController.swift
//  findTheNumberUI
//
//  Created by oktay on 9.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //views
    @IBOutlet weak var fieldGuess: UITextField!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var guessStatus: UIImageView!
    @IBOutlet weak var resutTextLabel: UILabel!
    @IBOutlet weak var guessCheckButton: UIButton!
    @IBOutlet weak var userGuessField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var typeIsValid: UIImageView!
    
    //variables
    var starts : [UIImageView] = [UIImageView]()
    var maxGuess :Int = 5 ;
    var currentGuess : Int = 1 ;
    var guess :Int = 0 ;
    var theNumber :Int = -1 ;
    var isSuccess : Bool = false ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews();
    }
    
    func setupViews() {
        starts = [star1, star2, star3, star4, star5]
        
        typeIsValid.isHidden = true
        guessStatus.isHidden = true
        resutTextLabel.isHidden = true
        resutTextLabel.text = ""
        guessCheckButton.isEnabled = false
        fieldGuess.isSecureTextEntry = true;
        //   fieldGuess.keyboardType = UIKeyboardType.numberPad
        userGuessField.keyboardType = UIKeyboardType.numberPad
        fieldGuess.placeholder = "Enter a number"
        guess = 0
        theNumber = 0
        isSuccess = false
        currentGuess = 1
        for star in self.starts {
            star.image = UIImage(named: "icons8-christmas-star-48")
        }
        saveButton.isEnabled = true
        userGuessField.backgroundColor = UIColor.white
        userGuessField.text = ""
        fieldGuess.text = ""
        self.fieldGuess.window?.becomeFirstResponder()
        fieldGuess.isEnabled = true
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        
        if let number =  Int(fieldGuess.text!)  {
            userGuessField.placeholder = "Try to guess"
            typeIsValid.isHidden = false
            theNumber = number
            guessCheckButton.isEnabled = true
            fieldGuess.isEnabled = false
            saveButton.isEnabled = false
            typeIsValid.image = UIImage(named: "ok")
        } else {
            typeIsValid.isHidden = false
            typeIsValid.image = UIImage(named: "error")
        }
    }
    
    @IBAction func tryAction(_ sender: Any) {
        
        if (isSuccess || guess > maxGuess) {
            return
        }
        guessStatus.isHidden = false
        if let number = Int(userGuessField.text!) {
            guess += 1
            starts[guess - 1].image = UIImage(named: "icons8-christmas-star-32")
            
            if (number > theNumber) {
                guessStatus.image = UIImage(named: "icons8-below-40")
                userGuessField.backgroundColor = UIColor.red
            } else if (number < theNumber){
                guessStatus.image = UIImage(named: "icons8-upward-arrow-48")
                userGuessField.backgroundColor = UIColor.red
            } else {
                guessStatus.image = UIImage(named: "icons8-ok-hand-48")
                userGuessField.backgroundColor = UIColor.green
                saveButton.isEnabled = false
                fieldGuess.isEnabled = true
                resutTextLabel.text = "YOU WIN"
                resutTextLabel.isHidden = false
                fieldGuess.isSecureTextEntry = false
                guessCheckButton.isEnabled = false
                isSuccess = true
                
                self.showAlert(alertTitle: "Congratulations",alertMessage: "You find the number",okActionTitle: "Good")
                return
            }
        } else {
            guessStatus.image = UIImage(named: "error")
        }
        
        
        if (maxGuess == guess) {
            guessCheckButton.isEnabled = false
            guessStatus.image = UIImage(named: "error")
            resutTextLabel.text = "YOU FAILD \n Number is: \(theNumber)"
            fieldGuess.isSecureTextEntry = false
            resutTextLabel.isHidden = false
            
            self.showAlert(alertTitle: "Error",alertMessage: "Your guess is over",okActionTitle:  "Close")
            return
        }
    }
    
    func showAlert (alertTitle:String, alertMessage:String, okActionTitle:String){
        let alert =  UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: okActionTitle, style: UIAlertAction.Style.default, handler: nil)
        
        let playAgainAction = UIAlertAction(title: "Again", style: UIAlertAction.Style.default){
            (action :UIAlertAction ) in
            self.setupViews()
        }
        
        alert.addAction(okAction)
        alert.addAction(playAgainAction)
        present(alert, animated: true, completion: nil)
    }
}

