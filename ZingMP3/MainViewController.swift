//
//  MainViewController.swift
//  ZingMP3
//
//  Created by Hung CIE on 8/10/17.
//  Copyright © 2017 Hung. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class MainViewController: UIViewController, AVAudioPlayerDelegate {
    //MARK: VARIBLE
    var isPlaying = true
    //END VARIBLE
    //MARK: OUTLET
    
    @IBOutlet weak var imgSinger: UIImageView!
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var sliderTimer: UISlider!
    @IBOutlet weak var labelSinger: UILabel!
    @IBOutlet weak var labelTenBaiHat: UILabel!
    @IBOutlet weak var labelTongThoiGian: UILabel!
    @IBOutlet weak var labelThoiGianChay: UILabel!
    @IBOutlet weak var button_PlayPause: UIButton!
    @IBOutlet weak var switchRepeat: UISwitch!
    var player = AVAudioPlayer()
    var currentTimePause : Float = 0
    //END OUTLET
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgSinger.layer.borderWidth = 1
        imgSinger.layer.masksToBounds = false
        imgSinger.layer.borderColor = UIColor.black.cgColor
        imgSinger.layer.cornerRadius = imgSinger.frame.height/2
        imgSinger.clipsToBounds = true
       
    }
    override func viewWillAppear(_ animated: Bool) {
        playSound()
        self.sliderTimer.maximumValue = Float(player.duration)
        print(player.duration)
        //set timer update current time
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UpdateCurrentTime) , userInfo: nil, repeats: true)
    }
    func UpdateCurrentTime(){
        labelThoiGianChay.text = player.currentTime.positionalTime
        labelTongThoiGian.text = player.duration.positionalTime
        self.sliderTimer.value = Float(player.currentTime)
        print("Current : \(player.currentTime)" )
        print("Duration : \(player.duration)" )
        print("Max slider: \(sliderTimer.maximumValue)")
        
    }
    //MARK: ACTION
    
    @IBAction func valueChangeVolume(_ sender: Any) {
        player.volume = sliderVolume.value
    }
    @IBAction func valueChangeCurrentTime(_ sender: Any) {
        player.currentTime = TimeInterval(sliderTimer.value)
    }
    @IBAction func touchUpInsidePlayPause(_ sender: Any) {
        if isPlaying {
            isPlaying = false
            //set btn img
            button_PlayPause.setImage(UIImage(named:"play"), for: .normal)
            currentTimePause = Float(player.currentTime)
            player.pause()
        }else{
            isPlaying = true
            //set btn img
            button_PlayPause.setImage(UIImage(named:"pause"), for: .normal)
            player.play()
            
        }
    }
    func playSound() {
        let url = Bundle.main.url(forResource: "a", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
             player.delegate = self
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if switchRepeat.isOn {
            button_PlayPause.setImage(UIImage(named:"pause"), for: .normal)
            player.play()
            isPlaying = true
        }else{
            button_PlayPause.setImage(UIImage(named:"play"), for: .normal)
            isPlaying = false
            
        }

    }
    //END ACTION
}
extension TimeInterval {
    struct DateComponents {
        static let formatterPositional: DateComponentsFormatter = {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour,.minute,.second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            return formatter
        }()
    }
    var positionalTime: String {
        return DateComponents.formatterPositional.string(from: self) ?? ""
    }
}
