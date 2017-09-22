//
//  ViewController.swift
//  ZingMP3
//
//  Created by Hung CIE on 8/5/17.
//  Copyright © 2017 Hung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblZingMp3: UILabel!
    @IBOutlet weak var lblMyName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lblZingMp3.alpha = 0
        lblMyName.alpha = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 1, animations: {
            self.lblZingMp3.alpha = 1
        }) { (finished) in
            UIView.animate(withDuration: 2, animations: {
                self.lblZingMp3.center = CGPoint(x: self.lblZingMp3.center.x, y: 100
                )
            }, completion: { (finished) in
                // điều hướng đến màn hình chính
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (finish) in
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "main") as! MainViewController
                    self.present(newViewController, animated: true, completion: nil)
                })
                
//                //hiển thị tên và chạy xuống dưới
//                UIView.animate(withDuration: 1, animations: {
//                    self.lblMyName.alpha = 1
//                    self.lblMyName.center = CGPoint(x: self.view.center.x, y: self.view.bounds.size.height - 30)
//                }, completion: { (finished) in
//                    print("Chạy xong")
//                   
//                })
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

