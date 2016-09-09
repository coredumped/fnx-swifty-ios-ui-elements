//
//  IndefiniteProgressViewController.swift
//  swiftyui4ios
//
//  Created by Juan Guerrero on 3/7/16.
//  Copyright © 2016 fn(x) Software. All rights reserved.
//

import UIKit
import swiftyui4ios

class IndefiniteProgressViewController: UIViewController {

    @IBOutlet var progress: IndefiniteProgressView!
    
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

    var animate = false
    @IBAction func animateProgress(_ sender: AnyObject) {
        animate = !animate
        progress.animating = animate
    }
}
