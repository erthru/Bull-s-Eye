//
//  ViewController.swift
//  Bulls Eye
//
//  Created by Suprianto Djamalu on 15/03/19.
//  Copyright © 2019 Suprianto Djamalu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderEye:UISlider!
    @IBOutlet weak var lbTarget:UILabel!
    @IBOutlet weak var lbRound:UILabel!
    @IBOutlet weak var lbScore:UILabel!
    
    private var currentSliderValue = 50
    private var targetSliderValue:Int? = nil
    private var round = 1
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSliderStyle()
        
        reset()
        
    }
    
    @IBAction func btnHitMeTapped(){
        
        var difference = 0
        var title:String
        
        if targetSliderValue! > currentSliderValue{
            difference = targetSliderValue! - currentSliderValue
        }else if currentSliderValue > targetSliderValue!{
            difference = currentSliderValue - targetSliderValue!
        }
        
        if difference == 0{
            title = "Perfect!"
        }else if difference <= 5{
            title = "You almost had it"
        }else if difference <= 15{
            title = "Good!"
        }else{
            title = "Not even close..."
        }
        
        let points = 100 - difference
        score += points
        
        let alert = UIAlertController(title: title, message: "You scored \(points)", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Close", style: .default, handler:nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true)
        
        reset()
        round += 1
        lbRound.text = "Round: \(round)"
        lbScore.text = "Score: \(score)"
        
    }
    
    @IBAction func sliderMove(_ slider:UISlider!){
        currentSliderValue = Int(slider.value.rounded())
    }
    
    
    @IBAction func startOver(){
        round = 1
        score = 0
        reset()
        lbScore.text = "Score: 0"
        lbRound.text = "Round: 1"
    }
    
    private func setSliderStyle(){
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        sliderEye.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        sliderEye.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        sliderEye.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        sliderEye.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }
    
    private func reset(){
        currentSliderValue = 50
        sliderEye.value = Float(currentSliderValue)
        targetSliderValue = Int.random(in: 0 ... 100)
        lbTarget.text = String(targetSliderValue!)
    }
    
}

