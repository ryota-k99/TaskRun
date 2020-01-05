//
//  ViewController.swift
//  タスクラン
//
//  Created by Kato Ryota  on 28/12/19.
//  Copyright © 2019 Kato Ryota . All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {


    
    @IBOutlet weak var taskTimePicker: UIPickerView!
    @IBOutlet weak var breakTimePicker: UIPickerView!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var alarmLabel: UILabel!
    
    let taskTimePickerArray = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"]
    
    let breakTimePickerArray = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60"]
    
    var taskTimeSet = 0
    var breakTimeSet = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1{
            
            return taskTimePickerArray[row] + "分"
            
        }else{
            return breakTimePickerArray[row] + "分"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return 60
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            taskTimeSet = Int(taskTimePickerArray[row])!
        }else{
            breakTimeSet = Int(breakTimePickerArray[row])!
        }
        
        if Int(taskTimeSet) == 0 || Int(breakTimeSet) == 0 {
            alarmLabel.isHidden = false
            StartButton.isEnabled = false
            if Int(taskTimeSet) == 0 && Int(breakTimeSet) != 0{
                alarmLabel.text = "作業時間を設定してください"
            }else if Int(taskTimeSet) != 0 && Int(breakTimeSet) == 0{
                alarmLabel.text = "休憩時間を設定してください"
            }else{
                alarmLabel.text = "時間を設定してください"
            }
        }else{
            StartButton.isEnabled = true
            alarmLabel.isHidden = true
            
        }
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        taskTimePicker.delegate = self
        taskTimePicker.tag = 1
            
        breakTimePicker.delegate = self
        breakTimePicker.tag = 2
        
        self.StartButton.layer.cornerRadius = 30.0
        alarmLabel.isHidden = true
        StartButton.isEnabled = false
        
        
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToSecondView", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondView"{
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.taskTimeSet = taskTimeSet
            destinationVC.breakTimeSet = breakTimeSet
            
        }
    }
    

}

