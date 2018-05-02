//
//  EndGameViewController.swift
//  Game
//
//  Created by Petar Stanev on 23/04/2018.
//  Copyright © 2018 Petar Stanev. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    var score: Int = 0
    var fileHelper = FileHelper()
    var textResultFileName: String = "results.txt"
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var saveScoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        scoreLabel.text = String(score)
        let textResult = fileHelper.read(fileName: textResultFileName)
        print(textResult)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveScore(_ sender: Any) {
        //let defaults = UserDefaults.standard
        //var highscores = defaults.stringArray(forKey: "test")
        let newscore = Score(name: nameText.text!, points: score)
        let defaults = UserDefaults.standard
        var scoresStrings = defaults.stringArray(forKey: "Scores") ?? [String]()
        scoresStrings.append(newscore.toString())
        defaults.set(scoresStrings, forKey: "Scores")
        //print("nameText.text" + nameText.text!);
        saveScoreButton.isEnabled = false
        saveScoreButton.setTitle("Score saved", for: .normal)
        nameText.isEnabled = false
        
        var textResult = fileHelper.read(fileName: textResultFileName)
        let newResultLine = textResult + newscore.toString() + ","
        fileHelper.write(fileName: textResultFileName, text: newResultLine)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
