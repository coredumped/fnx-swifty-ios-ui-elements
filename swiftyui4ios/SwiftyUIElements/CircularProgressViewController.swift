//
//  CircularProgressViewController.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 2/16/16.
//  Copyright © 2016 fn(x) Software. All rights reserved.
//

import UIKit
import swiftyui4ios

class CircularProgressViewController: UIViewController {

    @IBOutlet var circularProgress: CircularProgressView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func startProgress(sender: UIBarButtonItem) {
        NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
    }
    
    func updateProgress () {
        circularProgress.progress += 1.0 / 16.0
        if circularProgress.progress > 1.0 {
            circularProgress.progress = 0.0
        }
    }

}
