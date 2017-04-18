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
        
        case none
        case background
        case foregorund
    }
        
    
    @IBOutlet weak var destinationView: UIImageView!
    
    @IBOutlet weak var sourceView: MMSLayeredView!
    
    @IBOutlet weak var sliderPtSize: UISlider!
    
    var colorSelecting = WhichColor.none
    
    @IBAction func mergeTextWithImage(_ sender: UIButton) {
        
        
        destinationView.image = sourceView.mergeTextAndImage()
        
    }
    
    @IBAction func changedPtSize(_ sender: UISlider) {
        
        guard let focusView = sourceView.viewWithFocus as UIView! else {
            
            return
            
        }

        if focusView.isKind(of: UITextView.self) {
            
            let textView = focusView as! UITextView
            
            let newFont = textView.font!.withSize(CGFloat(sender.value))
            
            textView.font = newFont
            
        }
        
    }
    
    @IBAction func changeAlpha(_ sender: UISlider) {
        
        
        guard let focusView = sourceView.viewWithFocus as UIView! else {
            
            return
            
        }
        
        if focusView.isKind(of:UITextView.self) {
            
            let  textView = focusView as! UITextView
            
            textView.alpha = CGFloat(sender.value)
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        let backgroundImage = UIImage.init(named: "automobile.jpg")
        
        let backgroundView = UIImageView(image: backgroundImage)
        
        backgroundView.contentMode = .scaleToFill
        
        backgroundView.tag = 0
        
        sourceView.addBackgroundView(backgroundView: backgroundView)
        
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: sourceView.bounds.width/2, height: sourceView.bounds.height/2), textContainer: nil)
        
        textView.tag = 1
        
        textView.textAlignment = .center
        
        textView.isHidden = false; // the textView is modestly transparent
        
        textView.backgroundColor =  UIColor.clear // background color is see through
        
        textView.alpha = 1.0 // the background is modestly transparent
        
        textView.layer.borderWidth = 0.0 // the crop rectangle has a solid border
        
        textView.layer.borderColor = UIColor.black.cgColor // the crop border is white
        
        textView.isEditable = false
        
        textView.isSelectable = false
        
        textView.isUserInteractionEnabled = true
        
        textView.text = "\"To be or not to be...\"\n- William Shakespear"
        
        textView.font = UIFont.init(name: "MarkerFelt-Thin", size: 12.0)
        
        sourceView.addSubview(textView) // add the textView to the imageView
        
        let textView2 = UITextView(frame: CGRect(x: sourceView.bounds.width/2, y: sourceView.bounds.height/2, width: sourceView.bounds.width/2, height: sourceView.bounds.height/2), textContainer: nil)
        
        textView2.tag = 2
        
        textView2.textAlignment = .center
        
        textView2.isHidden = false; // the textView is modestly transparent
        
        textView2.backgroundColor =  UIColor.clear // background color is see through
        
        textView2.alpha = 1.0 // the background is modestly transparent
        
        textView2.layer.borderWidth = 0.0 // the crop rectangle has a solid border
        
        textView2.layer.borderColor = UIColor.black.cgColor // the crop border is white
        
        textView2.isEditable = false
        
        textView2.isSelectable = false
        
        textView2.isUserInteractionEnabled = true
        
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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "backgroundSegue" {
            
            colorSelecting = .background
            
        } else if identifier == "foregroundSegue" {
            
            colorSelecting = .foregorund
        }
        return true
    }
    
    func setColor(_ color:UIColor) -> Void {
        
        guard let focusView = sourceView.viewWithFocus else {
            
            return
            
        }
        
        if focusView.isKind(of:UITextView.self) {
            
            let textView = focusView as! UITextView
        
            if colorSelecting == .background {
            
                textView.backgroundColor = color
            
            } else if colorSelecting == .foregorund {
            
                textView.textColor = color
            
            }
            
        }
        
    }
    
    func setFont(_ fontName:String) -> Void {
        
        guard let focusView = sourceView.viewWithFocus as UIView! else {
            
            return
            
        }
        
        
        if focusView.isKind(of:UITextView.self) {
            
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

