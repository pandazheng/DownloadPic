//
//  ViewController.swift
//  DownloadPic
//
//  Created by pandazheng on 15/4/24.
//  Copyright (c) 2015年 pandazheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var iv : UIImageView!
    @IBOutlet var prog : UIProgressView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotPicture:", name: "GotPicture", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gotProgress:", name: "GotProgress", object: nil)
    }
    
    @IBAction func doStart (sender : AnyObject!)
    {
        self.prog.progress = 0
        self.iv.image = nil
        let del = UIApplication.sharedApplication().delegate as! AppDelegate
        del.startDownload(self)
    }
    
    @IBAction func doCrash (sender : AnyObject!)
    {
        println("test crash......\n")
    }
    
    func grabPicture ()
    {
        let del = UIApplication.sharedApplication().delegate as! AppDelegate
        self.iv.image = del.image
        del.image = nil
        if self.iv.image != nil
        {
            self.prog.progress = 1
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.grabPicture()
    }
    
    func gotPicture (n : NSNotification)
    {
        self.grabPicture()
    }
    
    func gotProgress (n : NSNotification)
    {
        if let ui = n.userInfo
        {
            if let prog = ui["progress"] as? NSNumber
            {
                self.prog.progress = Float(prog.doubleValue)
            }
        }
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

