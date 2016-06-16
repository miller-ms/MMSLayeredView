//
//  ViewController.swift
//  MMSLayeredView
//
//  Created by William Miller on 05/26/2016.
//  Copyright (c) 2016 William Miller. All rights reserved.
//

import UIKit
import MMSLayeredView

class ViewController: UIViewController {
    
    enum WhichColor {
        
        case None
        case Background
        case Foregorund
    }
        
    
    @IBOutlet weak var destinationView: UIImageView!
    
    @IBOutlet weak var sourceView: MMSLayeredView!
    
    @IBOutlet weak var sliderPtSize: UISlider!
    
    var colorSelecting = WhichColor.None
    
    @IBAction func mergeTextWithImage(sender: UIButton) {
        
        
        destinationView.image = sourceView.mergeTextAndImage()
        
    }
    
    @IBAction func changedPtSize(sender: UISlider) {
        
        guard let focusView = sourceView.viewWithFocus as UIView! else {
            
            return
            
        }

        if focusView.isKindOfClass(UITextView) {
            
            let textView = focusView as! UITextView
            
            let newFont = textView.font!.fontWithSize(CGFloat(sender.value))
            
            textView.font = newFont
            
        }
        
    }
    
    @IBAction func changeAlpha(sender: UISlider) {
        
        
        guard let focusView = sourceView.viewWithFocus as UIView! else {
            
            return
            
        }
        
        if focusView.isKindOfClass(UITextView) {
            
            let  textView = focusView as! UITextView
            
            textView.alpha = CGFloat(sender.value)
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        let backgroundImage = UIImage.init(named: "automobile.jpg")
        
        let backgroundView = UIImageView(image: backgroundImage)
        
        backgroundView.contentMode = .ScaleToFill
        
        backgroundView.tag = 0
        
        sourceView.addBackgroundView(backgroundView)
        
        let textView = UITextView(frame: CGRectMake(0, 0, sourceView.bounds.width/2, sourceView.bounds.height/2), textContainer: nil)
        
        textView.tag = 1
        
        textView.textAlignment = .Center
        
        textView.hidden = false; // the textView is modestly transparent
        
        textView.backgroundColor =  UIColor.clearColor() // background color is see through
        
        textView.alpha = 1.0 // the background is modestly transparent
        
        textView.layer.borderWidth = 0.0 // the crop rectangle has a solid border
        
        textView.layer.borderColor = UIColor.blackColor().CGColor // the crop border is white
        
        textView.editable = false
        
        textView.selectable = false
        
        textView.userInteractionEnabled = true
        
        textView.text = "\"To be or not to be...\"\n- William Shakespear"
        
        textView.font = UIFont.init(name: "MarkerFelt-Thin", size: 12.0)
        
        sourceView.addSubview(textView) // add the textView to the imageView
        
        let textView2 = UITextView(frame: CGRectMake(sourceView.bounds.width/2, sourceView.bounds.height/2, sourceView.bounds.width/2, sourceView.bounds.height/2), textContainer: nil)
        
        textView2.tag = 2
        
        textView2.textAlignment = .Center
        
        textView2.hidden = false; // the textView is modestly transparent
        
        textView2.backgroundColor =  UIColor.clearColor() // background color is see through
        
        textView2.alpha = 1.0 // the background is modestly transparent
        
        textView2.layer.borderWidth = 0.0 // the crop rectangle has a solid border
        
        textView2.layer.borderColor = UIColor.blackColor().CGColor // the crop border is white
        
        textView2.editable = false
        
        textView2.selectable = false
        
        textView2.userInteractionEnabled = true
        
        textView2.text = "\"Three blind mice, see how...\"\n- Mickey Mouse"
        
        textView2.font = UIFont.init(name: "MarkerFelt-Thin", size: 12.0)
        
        sourceView.addSubview(textView2) // add the textView to the imageView
        
        // Do any additional setup after loading the view, typically from a nib.
        
        sliderPtSize.minimumValue = 6
        
        sliderPtSize.maximumValue = 48
        
        sliderPtSize.value = Float((textView.font!.pointSize))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "backgroundSegue" {
            
            colorSelecting = .Background
            
        } else if identifier == "foregroundSegue" {
            
            colorSelecting = .Foregorund
        }
        return true
    }
    
    func setColor(color:UIColor) -> Void {
        
        guard let focusView = sourceView.viewWithFocus else {
            
            return
            
        }
        
        if focusView.isKindOfClass(UITextView) {
            
            let textView = focusView as! UITextView
        
            if colorSelecting == .Background {
            
                textView.backgroundColor = color
            
            } else if colorSelecting == .Foregorund {
            
                textView.textColor = color
            
            }
            
        }
        
    }
    
    func setFont(fontName:String) -> Void {
        
        guard let focusView = sourceView.viewWithFocus as UIView! else {
            
            return
            
        }
        
        
        if focusView.isKindOfClass(UITextView) {
            
            let textView = focusView as! UITextView
            
            
            var fontSize:CGFloat = 0.0
            
            if let textFont = textView.font {
                
                fontSize = textFont.pointSize
                
            } else {
                
                fontSize = 12.0
                
            }
            
            textView.font = UIFont.init(name: fontName, size: fontSize)
            
        }

        
    }

}

