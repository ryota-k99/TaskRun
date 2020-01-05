//
//  SecondViewController.swift
//  タスクラン
//
//  Created by Kato Ryota  on 28/12/19.
//  Copyright © 2019 Kato Ryota . All rights reserved.
//

import UIKit
import AVFoundation


class SecondViewController: UIViewController {
    
    @IBOutlet weak var taskTimeCountLabel: UILabel!
    @IBOutlet weak var breakTimeCountLabel: UILabel!
    @IBOutlet weak var taskTimeSetLabel: UILabel!
    @IBOutlet weak var breakTimeSetLabel: UILabel!
    @IBOutlet weak var taskTimeLabel: UILabel!
    @IBOutlet weak var breakTimeLabel: UILabel!
    @IBOutlet weak var taskTimeView: UIView!
    @IBOutlet weak var breakTimeView: UIView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    
    
    var taskTimeSet = 0
    var breakTimeSet = 0
    var taskTimeCount:[Int] = [00,00]
    var breakTimeCount:[Int] = [00,00]
    var timer = Timer()
    var timer2 = Timer()
    var passedSecond = 0
    var taskTimeSum = 0
    var breakTimeSum = 0
    
    var player:AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishButton.layer.cornerRadius = 30.0
        resetButton.layer.cornerRadius = 30.0
    
        taskTimeCount[0] = taskTimeSet
        taskTimeCountLabel.text = String(taskTimeCount[0]) + ":" + "00"
        taskTimeSetLabel.text = String(taskTimeCount[0]) + "分" 
        
        
        breakTimeCount[0] = breakTimeSet
        breakTimeCountLabel.text = String(breakTimeCount[0]) + ":" + "00"
        breakTimeSetLabel.text = String(breakTimeCount[0]) + "分"
        
        timeStarter()
    }
    
    func timeStarter(){
         taskTimeView.alpha = 0
         breakTimeView.alpha = 0.85
         timer.invalidate()
         passedSecond = 0
         timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(TaskTimerMethod), userInfo: nil, repeats: true)
         countdownTimer()
     }
      
      func breakTimeStarter()  {
        taskTimeView.alpha = 0.85
        breakTimeView.alpha = 0
         timer.invalidate()
         passedSecond = 0
         timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(breakTimerMethod), userInfo: nil, repeats: true)
         breakTimeCountdownTimer()
     }
          
      @objc func TaskTimerMethod(){
              timeMethod(time: taskTimeSet,timeSum: taskTimeSum)
              taskTimeSum += 1
     }
      
      @objc func breakTimerMethod(){
          timeMethod(time: breakTimeSet,timeSum: breakTimeSum)
          breakTimeSum += 1
     }
      
      @objc func timeMethod(time: Int,timeSum: Int){
             if passedSecond < time{
                 
                       passedSecond += 1

                       if passedSecond == time{
                           timer.invalidate()
                           print("Done!!!!")
                         
                       }
                   }else{
                 
                       timer.invalidate()
                       print("Done!!!!")
                 
                   }
      }

      func  countdownTimer(){
             timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdownTimerMethod), userInfo: nil, repeats: true)
             taskTimeCount[0] = taskTimeSet
      }

      @objc func countdownTimerMethod(){
             print(taskTimeCount[0],taskTimeCount[1])
             if (taskTimeCount[0] == 0 && taskTimeCount[1] == 0) {
                 taskTimeCountLabel.text = String(taskTimeSet) + ":" + "00"
                 timer2.invalidate()
                 playSound(soundName: "school-chime1")
                 breakTimeStarter()
             } else {
                 if taskTimeCount[1] > 0 {
                    taskTimeCount[1] -= 1
                 } else {
                     taskTimeCount[1] += 59
                     if taskTimeCount[0] > 0 {
                        taskTimeCount[0] -= 1
                     }
                 }
                 if taskTimeCount[1] < 10{
                     taskTimeCountLabel.text = String(taskTimeCount[0]) + ":" + "0" + String(taskTimeCount[1])
                 }else{
                     taskTimeCountLabel.text = String(taskTimeCount[0]) + ":" + String(taskTimeCount[1])
                 }

             }
         }


      func  breakTimeCountdownTimer(){
             timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakCountdownTimerMethod), userInfo: nil, repeats: true)
             breakTimeCount[0] = breakTimeSet
         }

      @objc func breakCountdownTimerMethod(){
             if (breakTimeCount[0] == 0 && breakTimeCount[1] == 0) {
                
                 breakTimeCountLabel.text = String(breakTimeSet) + ":" + "00"
                 timer2.invalidate()
                 playSound(soundName: "correct5")
                 
                 timeStarter()
             } else {
                 if breakTimeCount[1] > 0 {
                     breakTimeCount[1] -= 1
                 } else {
                     breakTimeCount[1] += 59
                     if breakTimeCount[0] > 0 {
                         breakTimeCount[0] -= 1
                     }
                 }
                if breakTimeCount[1] < 10{
                    breakTimeCountLabel.text = String(breakTimeCount[0]) + ":" + "0" + String(breakTimeCount[1])
                }else{
                 breakTimeCountLabel.text = String(breakTimeCount[0]) + ":" + String(breakTimeCount[1])
                }
             }
         }
    
    func playSound(soundName: String){
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.volume = 0.3
        if soundName == "correct5"{
            player.numberOfLoops = 2
            player.play()
        }else{
            player.play()
        }
        
    }

    
    @IBAction func finishButtonPressed(_ sender: Any) {
        
        timer.invalidate()
        timer2.invalidate()
        
        performSegue(withIdentifier: "goToThirdView", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToThirdView"{
            
            let destinationVC = segue.destination as! ThirdViewController
            destinationVC.taskTimeSum = taskTimeSum
            destinationVC.breakTimeSum = breakTimeSum
            
        }
    }
    
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        timer.invalidate()
        timer2.invalidate()
        
        self.dismiss(animated: true, completion: nil)
    }
    

     
     

}
