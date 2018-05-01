//
//  GameViewController.swift
//  Game
//
//  Created by Petar Stanev on 22/04/2018.
//  Copyright © 2018 Petar Stanev. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {

    var game = Game()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    @IBOutlet weak var answerFour: UIButton!
    
    
    @IBOutlet weak var heartOne: UIImageView!
    @IBOutlet weak var heartTwo: UIImageView!
    @IBOutlet weak var heartThree: UIImageView!
    
    
    @IBOutlet weak var arrowUp: UIImageView!
    @IBOutlet weak var arrowRight: UIImageView!
    @IBOutlet weak var arrowLeft: UIImageView!
    @IBOutlet weak var arrowDown: UIImageView!
    
    
    var player: AVAudioPlayer?
    
    @IBAction func musicButtonEvent(_ sender: UIButton) {
        print("music")
        guard let url = Bundle.main.url(forResource: "correct_answer", withExtension: "wav") else {
            print("url not found")
            return
        }
        do {
            /// this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            /// change fileTypeHint according to the type of your audio file (you can omit this)
            /// for iOS 11 onward, use :
            let player = try AVAudioPlayer(contentsOf: url)
            /// else :
            /// player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
            // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
            player.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
    @IBAction func vibrationButtonEvent(_ sender: UIButton) {
        print("vibration")
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        /*
            OR
         
         import AudioToolbox
         
         class ViewController: UIViewController {
         
         override func viewDidLoad() {
         super.viewDidLoad()
         AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
         }
         }
        */
		
    }
    
    @objc func swipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.up:
                answerOne.sendActions(for: .touchUpInside)
                //print("Swiped up")
            case UISwipeGestureRecognizerDirection.right:
                answerTwo.sendActions(for: .touchUpInside)
                //print("Swiped right")
            case UISwipeGestureRecognizerDirection.left:
                answerThree.sendActions(for: .touchUpInside)
                //print("Swiped left")
            case UISwipeGestureRecognizerDirection.down:
                answerFour.sendActions(for: .touchUpInside)
                //print("Swiped down")
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setSwipeActions()
        newQuestion()
        arrowUp.transform = CGAffineTransform(rotationAngle: (.pi / -2))
        arrowLeft.transform = CGAffineTransform(rotationAngle: (.pi))
        arrowDown.transform = CGAffineTransform(rotationAngle: (.pi / 2))
        
    }
    
    func setSwipeActions() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @IBAction func answerPress(_ sender: UIButton) {
        let question = game.question
        print(sender.tag)
        let answer = question.answers[sender.tag]
        if (answer.correct){
            game.score += 10
            newQuestion()
        }else{
            sender.backgroundColor = UIColor.red
            sender.isEnabled = false
            wrongAnswer()            
        }
        //update data
        scoreLabel.text = String(game.score)
    }
    
    func wrongAnswer() {
        game.lives-=1
        
        switch game.lives {
        case 2:
            heartThree.isHidden = true
        case 1:
             heartTwo.isHidden = true
        default:
            heartOne.isHidden = true
            performSegue(withIdentifier: "gameOverSeque", sender: self)
        }
    }
    
    func newQuestion() {
        let question = game.generateQuestion()
        
        questionLabel.text = question.printQuestion()
        answerOne.setTitle(question.answers[0].print(), for: .normal)
        answerTwo.setTitle(question.answers[1].print(), for: .normal)
        answerThree.setTitle(question.answers[2].print(), for: .normal)
        answerFour.setTitle(question.answers[3].print(), for: .normal)
        answerOne.isEnabled = true
        answerTwo.isEnabled = true
        answerThree.isEnabled = true
        answerFour.isEnabled = true
        answerOne.backgroundColor = UIColor(red: 115/255.0, green: 253/255.0, blue: 255/255.0, alpha: 1.00)
        answerTwo.backgroundColor = UIColor(red: 115/255.0, green: 253/255.0, blue: 255/255.0, alpha: 1.00)
        answerThree.backgroundColor = UIColor(red: 115/255.0, green: 253/255.0, blue: 255/255.0, alpha: 1.00)
        answerFour.backgroundColor = UIColor(red: 115/255.0, green: 253/255.0, blue: 255/255.0, alpha: 1.00)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gameOverSeque") {
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            let endVC = segue.destination as! EndGameViewController;
            endVC.score = game.score
        }
    }
    
    
}
