//
//  ViewController.swift
//  NVHiTunes
//
//  Created by Hùng Nguyễn  on 7/8/16.
//  Copyright © 2016 MobileSoftware. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var sld_Volume: UISlider!
    @IBOutlet weak var sld_Duration: UISlider!
    @IBOutlet weak var btn_Play: UIButton!
    @IBOutlet weak var btn_Previous: UIButton!
    @IBOutlet weak var btn_Next: UIButton!
    @IBOutlet weak var btn_Repeat: UIButton!
    @IBOutlet weak var btn_ListMusic: UIButton!
    @IBOutlet weak var btn_like: UIButton!
    @IBOutlet weak var btn_SleepReminder: UIButton!
    
    

    
    
    @IBOutlet weak var lbl_SongName: UILabel!
    @IBOutlet weak var lbl_Singers: UILabel!
    @IBOutlet weak var lbl_TimeCurrent: UILabel!
    @IBOutlet weak var lbl_TimeTotal: UILabel!
    
    @IBOutlet weak var swt_Repeat: UISwitch!
    
    
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var audioPlayer3 = AVAudioPlayer()
    
    var recordDisc = UIImageView()
    var discRadious: CGFloat = 100.0
    
    var radians = CGFloat()
    var timer1 = NSTimer()
    var timer2 = NSTimer()
    var repeated = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Justin+Bieber+-+Beauty+And+A+Beat+(feat.+Nicki+Minaj)(music.naij.com)", ofType: ".mp3")!))
        audioPlayer2 = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Sugar - Maroon 5 [MP3 128kbps]", ofType: ".mp3")!))
        audioPlayer3 = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Faded - Alan Walker_ Iselin Solheim [MP3 128kbps]", ofType: ".mp3")!))
        
        audioPlayer.prepareToPlay()
        audioPlayer2.prepareToPlay()
        audioPlayer3.prepareToPlay()

        
        lbl_SongName.text = "Beauty And A Beat"
        lbl_SongName.textColor = UIColor.blackColor()
        lbl_Singers.text = "Justin Bieber feat. Nicki Minaj"
        lbl_Singers.textColor = UIColor.blackColor()
        lbl_Singers.alpha = 0.7
        
        addImages()
        addRecordDisc()
        rollingDisc()
        audioPlayer.play()
        
        
        
        audioPlayer.delegate = self
        audioPlayer2.delegate = self
        audioPlayer3.delegate = self
        
        updateTimeTotal()
       timer1 =  NSTimer.scheduledTimerWithTimeInterval(1/60, target: self, selector: #selector(rollingDisc), userInfo: nil, repeats: true)
        timer2 =  NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateTimeCurrent), userInfo: nil, repeats: true)
        repeated = false
        
        
    }
// setup section
    
    @IBAction func action_Play(sender: UIButton) {
        switch lbl_SongName.text! {
        case "Beauty And A Beat":
            audioPlayer2.stop()
            audioPlayer3.stop()
            if btn_Play.currentBackgroundImage == UIImage(named: "pause.png") {
                btn_Play.setBackgroundImage(UIImage(named: "play.png"), forState: .Normal)
                audioPlayer.pause()
                timer1.invalidate()
                print("pause")
            }
            else {
                btn_Play.setBackgroundImage(UIImage(named: "pause.png"), forState: .Normal)
                audioPlayer.play()
                timer1 =  NSTimer.scheduledTimerWithTimeInterval(1/60, target: self, selector: #selector(rollingDisc), userInfo: nil, repeats: true)
                print("play")
            }
        case "Sugar":
            audioPlayer.stop()
            audioPlayer3.stop()
            if btn_Play.currentBackgroundImage == UIImage(named: "pause.png") {
                btn_Play.setBackgroundImage(UIImage(named: "play.png"), forState: .Normal)
                audioPlayer2.pause()
                timer1.invalidate()
                print("pause")
            }
            else {
                btn_Play.setBackgroundImage(UIImage(named: "pause.png"), forState: .Normal)
                audioPlayer2.play()
                timer1 =  NSTimer.scheduledTimerWithTimeInterval(1/60, target: self, selector: #selector(rollingDisc), userInfo: nil, repeats: true)
                print("play")
            }
        case "Faded":
            audioPlayer.stop()
            audioPlayer2.stop()
            if btn_Play.currentBackgroundImage == UIImage(named: "pause.png") {
                btn_Play.setBackgroundImage(UIImage(named: "play.png"), forState: .Normal)
                audioPlayer3.pause()
                timer1.invalidate()
                print("pause")
            }
            else {
                btn_Play.setBackgroundImage(UIImage(named: "pause.png"), forState: .Normal)
                audioPlayer3.play()
                timer1 =  NSTimer.scheduledTimerWithTimeInterval(1/60, target: self, selector: #selector(rollingDisc), userInfo: nil, repeats: true)
                print("play")
            }

        default:
            break
        }
    }
    
    @IBAction func action_Next(sender: UIButton) {
        switch lbl_SongName.text! {
        case "Beauty And A Beat":
            lbl_SongName.text = "Sugar"
            lbl_SongName.textColor = UIColor.blackColor()
            lbl_Singers.text = "Maroon 5"
            lbl_Singers.textColor = UIColor.blackColor()
            lbl_Singers.alpha = 0.7
            audioPlayer.stop()
            audioPlayer3.stop()
            btn_like.setBackgroundImage(UIImage(named: "player-track-like-love-music.png"), forState: .Normal)
            
            addRecordDisc()
            audioPlayer2.play()
        case "Sugar":
            audioPlayer.stop()
            audioPlayer2.stop()
            lbl_SongName.text = "Faded"
            lbl_SongName.textColor = UIColor.blackColor()
            lbl_Singers.text = "Alan Walker_ Iselin Solheim"
            lbl_Singers.textColor = UIColor.blackColor()
            lbl_Singers.alpha = 0.7
            btn_like.setBackgroundImage(UIImage(named: "player-track-like-love-music.png"), forState: .Normal)
            
            addRecordDisc()
            audioPlayer3.play()
        case "Faded":
            lbl_SongName.text = "Beauty And A Beat"
            lbl_SongName.textColor = UIColor.blackColor()
            lbl_Singers.text = "Justin Bieber feat. Nicki Minaj"
            lbl_Singers.textColor = UIColor.blackColor()
            lbl_Singers.alpha = 0.7
            audioPlayer2.stop()
            audioPlayer3.stop()
            btn_like.setBackgroundImage(UIImage(named: "player-track-like-love-music.png"), forState: .Normal)
            
            addRecordDisc()
            audioPlayer.play()
        default:
            break
        }
        updateTimeTotal()
        print("Next")
    }
    
    @IBAction func action_Previous(sender: UIButton) {
        switch lbl_SongName.text! {
        case "Beauty And A Beat":
            audioPlayer.stop()
            audioPlayer2.stop()
            lbl_SongName.text = "Faded"
            lbl_SongName.textColor = UIColor.blackColor()
            lbl_Singers.text = "Alan Walker_ Iselin Solheim"
            lbl_Singers.textColor = UIColor.blackColor()
            lbl_Singers.alpha = 0.7
            btn_like.setBackgroundImage(UIImage(named: "player-track-like-love-music.png"), forState: .Normal)
            
            addRecordDisc()
            audioPlayer3.play()
        case "Faded":
            lbl_SongName.text = "Sugar"
            lbl_SongName.textColor = UIColor.blackColor()
            lbl_Singers.text = "Maroon 5"
            lbl_Singers.textColor = UIColor.blackColor()
            lbl_Singers.alpha = 0.7
            audioPlayer.stop()
            audioPlayer3.stop()
            btn_like.setBackgroundImage(UIImage(named: "player-track-like-love-music.png"), forState: .Normal)
            
            addRecordDisc()
            audioPlayer2.play()
        case "Sugar":
            lbl_SongName.text = "Beauty And A Beat"
            lbl_SongName.textColor = UIColor.blackColor()
            lbl_Singers.text = "Justin Bieber feat. Nicki Minaj"
            lbl_Singers.textColor = UIColor.blackColor()
            lbl_Singers.alpha = 0.7
            audioPlayer2.stop()
            audioPlayer3.stop()
            btn_like.setBackgroundImage(UIImage(named: "player-track-like-love-music.png"), forState: .Normal)
            
            addRecordDisc()
            audioPlayer.play()
        default:
            break
        }
        updateTimeTotal()
        print("Previous")
    }
    
    
    @IBAction func action_ShowListMusic(sender: UIButton) {
        print("List songs")
    }
    
    
    @IBAction func action_Repeat(sender: UIButton) {
        if btn_Repeat.currentBackgroundImage == UIImage(named: "no_repeat.png") {
            btn_Repeat.setBackgroundImage(UIImage(named: "repeat-current.png"), forState: .Normal)
            print("Repeat current list")
        } else {
            if btn_Repeat.currentBackgroundImage == UIImage(named: "repeat-current.png") {
                        btn_Repeat.setBackgroundImage(UIImage(named: "Repeat_Once.png"), forState: .Normal)
                        print("Repeat once")
            } else {
                if btn_Repeat.currentBackgroundImage == UIImage(named: "Repeat_Once.png") {
                            btn_Repeat.setBackgroundImage(UIImage(named: "no_repeat.png"), forState: .Normal)
                            print("No repeat")
                }

            }
 
        }
        
    }
    
    @IBAction func action_LikeMusic(sender: UIButton) {
        switch lbl_SongName.text! {
        case "Beauty And A Beat":
            if btn_like.currentBackgroundImage == UIImage(named: "player-track-like-love-music.png") {
                btn_like.setBackgroundImage(UIImage(named: "love-music-hightlight.png"), forState: .Normal)
                print("I love \(lbl_SongName.text!) - \(lbl_Singers.text!)")
            } else {
                btn_like.setBackgroundImage(UIImage(named: "player-track-like-love-music.png"), forState: .Normal)
            }
            
        case "Sugar":
            if btn_like.currentBackgroundImage == UIImage(named: "player-track-like-love-music.png") {
                btn_like.setBackgroundImage(UIImage(named: "love-music-hightlight.png"), forState: .Normal)
                print("I love \(lbl_SongName.text!) - \(lbl_Singers.text!)")
            } else {
                btn_like.setBackgroundImage(UIImage(named: "player-track-like-love-music.png"), forState: .Normal)
            }

        case "Faded":
            if btn_like.currentBackgroundImage == UIImage(named: "player-track-like-love-music.png") {
                btn_like.setBackgroundImage(UIImage(named: "love-music-hightlight.png"), forState: .Normal)
                print("I love \(lbl_SongName.text!) - \(lbl_Singers.text!)")
            } else {
                btn_like.setBackgroundImage(UIImage(named: "player-track-like-love-music.png"), forState: .Normal)
            }

        default:
            break
        }
    }
    
    @IBAction func action_Sleepping(sender: UIButton) {
        if btn_SleepReminder.currentBackgroundImage == UIImage(named: "sleep-reminder.png") {
            btn_SleepReminder.setBackgroundImage(UIImage(named: "sleeping.png"), forState: .Normal)
            print("Turn on sleeping mode")
        } else {
            btn_SleepReminder.setBackgroundImage(UIImage(named: "sleep-reminder.png"), forState: .Normal)
            print("Turn off sleeping mode")
        }
    }
    
    @IBAction func action_MinVolume(sender: UIButton) {
        audioPlayer.volume = sld_Volume.minimumValue
        audioPlayer2.volume = sld_Volume.minimumValue
        audioPlayer3.volume = sld_Volume.minimumValue
        
        sld_Volume.value = sld_Volume.minimumValue
    }
    
    @IBAction func action_MaxVolume(sender: UIButton) {
        audioPlayer.volume = sld_Volume.maximumValue
        audioPlayer2.volume = sld_Volume.maximumValue
        audioPlayer3.volume = sld_Volume.maximumValue

        sld_Volume.value = sld_Volume.maximumValue
        
    }
    
    
    @IBAction func sld_Volume(sender: UISlider) {
        audioPlayer.volume = sender.value
        audioPlayer2.volume = sender.value
        audioPlayer3.volume = sender.value
        
    }
    
    @IBAction func sld_Duration(sender: UISlider) {
        audioPlayer.currentTime = Double(sender.value) * audioPlayer.duration
        audioPlayer2.currentTime = Double(sender.value) * audioPlayer2.duration
        audioPlayer3.currentTime = Double(sender.value) * audioPlayer3.duration
    }
    
    @IBAction func swt_Repeat(sender: UISwitch) {
        if sender.on == true {
            repeated = true
            } else {
            repeated = false
        }
    }
    
    func updateTimeCurrent() {
        switch lbl_SongName.text! {
        case "Beauty And A Beat":
            lbl_TimeCurrent.text = String(format: "%02d:%02d", Int(audioPlayer.currentTime / 60), Int(audioPlayer.currentTime % 60))
            self.sld_Duration.value = Float(audioPlayer.currentTime / audioPlayer.duration)
        case "Sugar":
            lbl_TimeCurrent.text = String(format: "%02d:%02d", Int(audioPlayer2.currentTime / 60), Int(audioPlayer2.currentTime % 60))
            self.sld_Duration.value = Float(audioPlayer2.currentTime / audioPlayer2.duration)
        case "Faded":
            lbl_TimeCurrent.text = String(format: "%02d:%02d", Int(audioPlayer3.currentTime / 60), Int(audioPlayer3.currentTime % 60))
            self.sld_Duration.value = Float(audioPlayer3.currentTime / audioPlayer3.duration)
        default:
            break
        }
              }
    
    
    func updateTimeTotal() {
        switch lbl_SongName.text! {
        case "Beauty And A Beat":
            lbl_TimeTotal.text = String(format: "%02d:%02d", Int(audioPlayer.duration / 60), Int(audioPlayer.duration % 60))
        case "Sugar":
            lbl_TimeTotal.text = String(format: "%02d:%02d", Int(audioPlayer2.duration / 60), Int(audioPlayer2.duration % 60))
        case "Faded":
            lbl_TimeTotal.text = String(format: "%02d:%02d", Int(audioPlayer3.duration / 60), Int(audioPlayer3.duration / 60))
        default:
            break
        }
        
    }
    
    
    
    func addImages() {
        // playImage
        btn_Play.setBackgroundImage(UIImage(named: "pause.png"), forState: .Normal)
        // thumbImage
        sld_Volume.setThumbImage(UIImage(named: "thumb.png"), forState: .Normal)
        sld_Volume.setThumbImage(UIImage(named: "thumbHightLight.png"), forState: .Highlighted)
        // likeImage
        btn_like.setBackgroundImage(UIImage(named: "player-track-like-love-music.png"), forState: .Normal)
        // sleepImage
        btn_SleepReminder.setBackgroundImage(UIImage(named: "sleep-reminder.png"), forState: .Normal)
        // set defautl repeat mode is no-repeat
        btn_Repeat.setBackgroundImage(UIImage(named: "no_repeat.png"), forState: .Normal)
        
    }
    
    func addRecordDisc() {
        let mainViewSize = self.view.bounds.size
        switch lbl_SongName.text! {
        case "Beauty And A Beat":
            recordDisc = UIImageView(image: UIImage(named: "justin-bieber-record.png"))
            recordDisc.center = CGPointMake(mainViewSize.width * 0.5 , mainViewSize.height * 0.375 )
            self.view.addSubview(recordDisc)
        case "Sugar":
            recordDisc = UIImageView(image: UIImage(named: "Maroon_5_Sugar_cover.png"))
            recordDisc.center = CGPointMake(mainViewSize.width * 0.5, mainViewSize.height * 0.375)
            self.view.addSubview(recordDisc)
        case "Faded":
            recordDisc = UIImageView(image: UIImage(named: "alan-walker-faded .png"))
            recordDisc.center = CGPointMake(mainViewSize.width * 0.5, mainViewSize.height * 0.375)
            self.view.addSubview(recordDisc)
        default:
            break
        }
        
        
    }
    
    func rollingDisc()  {
        let deltaAngle : CGFloat = 0.01
        radians = radians + deltaAngle
        recordDisc.transform = CGAffineTransformMakeRotation(radians)
        
    }
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if repeated == true {
            switch lbl_SongName.text! {
            case "Beauty And A Beat":
                audioPlayer.play()
            case "Sugar":
                audioPlayer2.play()
            case "Faded":
                audioPlayer3.play()
            default:
                break
            }
            btn_Play.setBackgroundImage(UIImage(named: "pause.png"), forState: .Normal)
            print("switch on")
        } else {
            btn_Play.setBackgroundImage(UIImage(named: "play.png"), forState: .Normal)
            print("switch off")
        }
    }

}