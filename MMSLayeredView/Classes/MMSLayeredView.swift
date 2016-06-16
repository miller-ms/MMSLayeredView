//
//  MMSLayeredView.swift
//  Pods
//
//  Created by William Miller on 5/26/16.
//
//  Copyright (c) 2016 William Miller <support@millermobilesoft.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


import UIKit

internal enum FocusState {
    case BackgroundFocus
    case SizeFocus
    case MoveFocus
    case ScaleFocus
}

public class MMSLayeredView: UIView, UIGestureRecognizerDelegate {

    // MARK: Class Properties
    
    public var viewWithFocus: UIView? = nil
    
    private var resizeFrameStart = CGRectZero
    
    //    var scaleStart:CGFloat = 0.0
    
    private var sizePointStart = CGPointZero
    
    private var isFocusSet = false
    
    private var focusState = FocusState.BackgroundFocus
    
    /// The first touchpoint when the user began moving the textView
    private var touchOrigin = CGPointZero
    
    /// The dragOrigin is the first point the user touched to begin the drag operation to delineate the crop rectangle.
    private var dragOrigin = CGPointZero
    
    /// Layer that obscures the outside region of the crop rectangle
    private var maskLayer = CAShapeLayer()
    
    /// Opacity for the shaded area outside the crop rectangle
    private let focusOpacity = Float(0.65)
    
    private let moveOpacity = Float(0.85)
    
    /// Opacity for the area under the crop rectangle is transparent
    private let transparentOpacity = Float(0.0)
    
    /// The color for the shaded area outside the crop rectangle is black.
    private let maskColor = (UIColor).blackColor()
    
    
    // MARK: Class Initialization
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        
        initializeInstance()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        initializeInstance()
    }
    
    /**
     Initializes all the subviews and connects the gestures to the corresponding views and their action methods.
     */
    func initializeInstance() {
        
        
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        maskLayer.fillColor = maskColor.CGColor
        
        maskLayer.opacity = transparentOpacity
                
    }
    
    /**
     Creates two rectangular paths. One is set to the dimensions of the UIImageVie and a smaller one appended to the first that is the size and origin of the cropRect.
     
     - parameter mask     The shape layer added to the UIImageView
     - parameter cropRect The rectangular dimensions of area within the first shape to show transparent.
     
     - returns: returns the mask
     */
    func calculateMaskLayer (mask:CAShapeLayer, insideRect: CGRect) -> CAShapeLayer {
        
        // Create a rectangular path to enclose the circular path within the bounds of the passed in layer size.
        let outsidePath = UIBezierPath(rect: bounds)
        
        let insidePath = UIBezierPath(rect: insideRect)
        
        outsidePath.appendPath(insidePath)
        
        mask.path = outsidePath.CGPath;
        
        return mask
        
    }
    
    
    // MARK: Gesture Delegate
    /**
     Always recognize the gesture.
     
     - parameter gestureRecognizer: An instance of a subclass of the abstract base class UIGestureRecognizer.
     
     - returns: returns true to recognize the gesture.
     */
    override public func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
        
    }
    
    /**
     The gesture delegate method to check if two gestures should be recognized simultaniously.  The tap and pan gestures are recognized simultaneously by the UIImageView.
     
     - parameter gestureRecognizer      An instance of a subclass of the abstract base class UIGestureRecognizer.  This is the object sending the message to the delegate.
     - parameter otherGestureRecognizer: An instance of a subclass of the abstract base class UIGestureRecognizer.
     
     - returns: Returns true to detect the tap gesture and pan gesture simultaneously.
     */
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        
        /* Enable to recognize the pan and tap gestures simultaneous for both the imageView and textView
         */
        if gestureRecognizer.isKindOfClass(UITapGestureRecognizer) && otherGestureRecognizer.isKindOfClass(UIPanGestureRecognizer) {
            
            return true
            
        } else {
            
            return false
        }
        
        
    }
    
    
    // MARK: - Gesture Action handlers
    
    
    /**
     The pinch gesture aspect resizes the target view.
     
     - parameter gesture: The pinch gesture.
     */
    @IBAction func scaleView(gesture:UIPinchGestureRecognizer) {
        
        if gesture.state == .Began {
            
            resizeFrameStart = gesture.view!.frame
            
            giveFocus(gesture.view!, withState: .ScaleFocus)
            
        } else if gesture.state == .Changed {
            
            print("Change scale ", gesture.scale)
            
            var resizedFrame = resizeFrameStart
            
            //            let heightChange = resizeFrameStart.height - (resizeFrameStart.height * (gesture.scale+scaleStart))
            //
            //            let widthChange = resizeFrameStart.width - (resizeFrameStart.width * (gesture.scale+scaleStart))
            
            /// Compute the change in the height and width
            let heightChange = resizeFrameStart.height - (resizeFrameStart.height * gesture.scale)
            
            let widthChange = resizeFrameStart.width - (resizeFrameStart.width * gesture.scale)
            
            /// Reposition the orign so that the view grows and shrinks from the center
            resizedFrame.origin.x = resizeFrameStart.origin.x + (widthChange/2)
            
            resizedFrame.origin.y = resizeFrameStart.origin.y + (heightChange/2)
            
            /// Compute the new size of the view
            resizedFrame.size = CGSizeMake(resizedFrame.width - widthChange, resizedFrame.height - heightChange)
            
            /// Keep the orign from moving out of bounds.
            if resizedFrame.origin.x < 0 {
                
                resizedFrame.origin.x = 0
                
            }
            
            if resizedFrame.origin.y < 0  {
                
                resizedFrame.origin.y = 0
                
            }
            
            /// keep the height and width from being larger than the bounding frame.
            if resizedFrame.size.width > frame.size.width {
                
                resizedFrame.size.width = frame.size.width
                
            }
            
            if resizedFrame.size.height > frame.size.height {
                
                resizedFrame.size.height = frame.size.height
                
            }
            
            /// when factoring the origin keep the lower right courner within the dimensions of the bounding frame
            if resizedFrame.size.height + resizedFrame.origin.y > frame.size.height {
                
                let heightDifference =  (resizedFrame.size.height + resizedFrame.origin.y) - frame.size.height
                
                resizedFrame.origin.y -= heightDifference
                
                if resizedFrame.origin.y < 0 {
                    
                    resizedFrame.origin.y = 0
                    
                }
                
            }
            
            if resizedFrame.size.width + resizedFrame.origin.x > frame.size.width {
                
                let widthDifference =  (resizedFrame.size.width + resizedFrame.origin.x) - frame.size.width
                
                resizedFrame.origin.x -= widthDifference
                
                if resizedFrame.origin.x < 0 {
                    
                    resizedFrame.origin.x = 0
                }
                
            }
            
            /// Assign the newly computed scaled frame to the view
            gesture.view!.frame = resizedFrame
            
            ///  The mask layer must move with the crop rectangle.
            calculateMaskLayer(maskLayer, insideRect: gesture.view!.frame)
            
            
        } else if gesture.state == .Ended {
            
            removeFocus()
            
        }
        
    }
    
    
    /**
     
     Two fingers were touched within the boundaries of the text view. The height and width change without respect to aspect ratio based on the new position of the touch relative to the start position.
     
     - parameter gesture: A reference to the pan gesture.
     */
    func sizeView(gesture:UIPanGestureRecognizer) {
        
        if gesture.state == .Began {
            
            /// save the frame size and touchpoint to compute changes as the figure is moved
            
            resizeFrameStart = gesture.view!.frame
            
            //            maskLayer.opacity = shadedOpacity
            
            sizePointStart = gesture.locationInView(self)
            
            /// give focus to the target view.
            giveFocus(gesture.view!, withState: .SizeFocus)
            
            
        } else if gesture.state == .Changed {
            
            /// Get the current touchpoint position and the original frame size to recalculate the frame
            let currentPoint = gesture.locationInView(self)
            
            var resize = resizeFrameStart.size
            
            
            //            let xChange = currentPoint.x - sizePointStart.x
            //
            //            let yChange = currentPoint.y - sizePointStart.y
            
            
            /// Add the difference of the current touchpoint y and x positions to the resize height and width.
            resize.height += currentPoint.y - sizePointStart.y
            
            resize.width += currentPoint.x - sizePointStart.x
            
            /// get the current frame rect of the target view
            let targetFrame = gesture.view!.frame
            
            /// reset height to the original height if the calculated one is less than zero
            if resize.height <= 0 {
                resize.height = targetFrame.size.height
            }
            
            /// reset width to the original height if the calculated one is less than zero
            if resize.width <= 0 {
                
                resize.width = targetFrame.size.width
            }
            
            /// set the height to extend to the bottom of the enclosing frame if the resized one extends beyond.
            if resize.height + targetFrame.origin.y >= frame.size.height {
                resize.height = resize.height - ((resize.height + targetFrame.origin.y) - frame.size.height)
            }
            
            /// set the width to extend to the bottom of the enclosing frame if the resized one extends beyond.
            if resize.width + targetFrame.origin.x >= frame.size.width {
                resize.width = resize.width - ((resize.width + targetFrame.origin.x) - frame.size.width)
            }
            
            gesture.view!.frame = CGRectMake(targetFrame.origin.x, targetFrame.origin.y, resize.width, resize.height)
            
            /*  The mask layer must move with the crop rectangle.
             */
            calculateMaskLayer(maskLayer, insideRect: gesture.view!.frame)
            
            
        } else if gesture.state == .Ended {
            
            //            maskLayer.opacity = transparentOpacity
            
            /// gesture has ended. remove the focus
            removeFocus()
            
        }
        
    }
    
    
    /**
     A finger was touched within the boundaries of the text view. It's responsible for repositioning the crop rectangle over the image based on the coordinates of touchpoint.
     
     - parameter gesture: A reference to the pan gesture.
     */
    func moveView(gesture:UIPanGestureRecognizer) {
        
        
        if gesture.state == UIGestureRecognizerState.Began {
            
            /*  save the crop view frame's origin to compute the changing position as the finger glides around the screen.  Also, save the first touch point compute the amount to change the frames orign.
             */
            touchOrigin = gesture.locationInView(self)
            
            dragOrigin = gesture.view!.frame.origin
            
        } else if gesture.state == .Changed {
            
            /* Compute the change in x and y coordinates with respect to the original touch point.  Compute a new x and y point by adding the change in x and y to the crop view's origin before it was moved. Make this point the new origin.
             */
            
            let currentPt = gesture.locationInView(self)
            
            let dx = currentPt.x - touchOrigin.x
            
            let dy = currentPt.y - touchOrigin.y
            
            gesture.view!.frame = CGRectMake(dragOrigin.x+dx, dragOrigin.y+dy, gesture.view!.frame.size.width, gesture.view!.frame.size.height)
            
            gesture.view!.frame = restrictMoveWithinFrame(gesture.view!.frame)
            
            calculateMaskLayer(maskLayer, insideRect: gesture.view!.frame)
            
        } else if gesture.state == .Ended {
            
            /// gesture has ended. remove the focus
            removeFocus()
            
        }
    }
    
    /**
     Responds to the pan gesture and based on the focus type set, it either interprets the pan as a move request or size request.
     
     - parameter gesture: A reference to the pan gesture.
     */
    
    @IBAction func panView(gesture:UIPanGestureRecognizer) {
        
        if focusState == .MoveFocus {
            
            moveView(gesture)
            
        } else {
            
            sizeView(gesture)
            
        }
    }
    
    /**
     The layered view receiving a single tap gesture is given focus if it doesn't already have it.  If it does, focus is removed.
     
     - parameter gesture: The tap gesture
     */
    @IBAction func toggleFocus(gesture:UITapGestureRecognizer) {
        
        if isFocusSet {
            
            if viewWithFocus == gesture.view {
                
                /// if the view with focus was tapped remove the focus and clear the visual focus indicator
                removeFocus()
                
            } else {
                
                /// if a view different from the one with focus was tapped remove the focus and give it to the newly tapped view
                removeFocus()
                
                giveFocus(gesture.view!, withState: .SizeFocus)
                
            }
            
        } else {
            
            /// None of the layered views had focus.  Set it to the target and show the visual indicator
            giveFocus(gesture.view!, withState: .SizeFocus)
            
        }
        
    }
    
    /**
     The layered view receiving a double tap gesture is given focus if it doesn't already have it.  If it does, focus is removed.
     
     - parameter gesture: The tap gesture
     */
    @IBAction func moveFocus(gesture:UITapGestureRecognizer) {
        
        giveFocus(gesture.view!, withState: .MoveFocus)
        
    }

    
    // MARK: Helper Methods
    
    
    /**
     Sets member variables to indicate no view has focus
     */
    func removeFocus () -> Void {
        
        
        viewWithFocus = getBackgroundView()
        
        focusState = .BackgroundFocus
        
        isFocusSet = false
        
        maskLayer.opacity = transparentOpacity
        
        
    }
    /**
     Sets member variables to indicate a view has focus and sets focus to the input view.  Depending on the focus state the opacity is different.  Move focus has less transparency than size focus.
     
     - parameter toView: layered view to give focus
     */
    func giveFocus(toView:UIView, withState newState:FocusState) -> Void {
        
        viewWithFocus = toView
        
        focusState = newState
        
        isFocusSet = true
        
        if newState == .MoveFocus {
            
            maskLayer.opacity = moveOpacity
            
        } else {
            
            maskLayer.opacity = focusOpacity
            
        }
        
        calculateMaskLayer(maskLayer, insideRect: toView.frame)
        
        
    }
    
    
    /**
     Checks if the bottom right corner and upper left corners of the input rectangle fall within boundary of the image frame. If either corner falls outside, it recalculates the respective origin's coordinate that falls outside the boundary to keep the rectangle witin the frame.  To restrict the move, the origin is always adjusted to maintain the size.
     
     - parameter cropFrame A rectangle representing the crop frame to check.
     
     - returns: returns the input rectangle unchanged if all the dimensions fall within the image frame; otherwise, a rectangle where the origin is recalculate to keep the rectangle within the boundary.
     */
    func restrictMoveWithinFrame (textFrame: CGRect) -> CGRect {
        
        var restrictedFrame = textFrame
        
        /* If the origin's y coordinate falls outside the image frame, recalculate it to fall on the boundary.
         */
        if restrictedFrame.origin.y < 0 {
            
            restrictedFrame.origin.y = 0
            
        }
        
        /* If the bottom right corner's y coordinate falls outside the image frame, recalculate the origin's y coordinate to fit the bottom right corner within the height boundary.
         */
        if (restrictedFrame.origin.y + restrictedFrame.height) > frame.height {
            
            restrictedFrame.origin.y = restrictedFrame.origin.y - (restrictedFrame.origin.y + restrictedFrame.height - frame.height)
            
        }
        
        /* If the origin's x coordinate falls outside the image frame, recalculate it to fall on the boundary.
         */
        if restrictedFrame.origin.x < 0 {
            
            restrictedFrame.origin.x = 0
            
        }
        
        /* If the bottom right corner's x coordinate falls outside the image frame, recalculate the origin's x coordinate to fit the bottom right corner within the width boundary.
         */
        if (restrictedFrame.origin.x + restrictedFrame.width) > frame.width {
            
            restrictedFrame.origin.x = restrictedFrame.origin.x - (restrictedFrame.origin.x + restrictedFrame.width - frame.width)
            
        }
        
        return restrictedFrame
        
    }
    
    
    /**
     Checks if the bottom right corner and upper left corners of the input rectangle fall with in boundary of the image frame. If either corner falls outside, it resets the corner to fall on the boundary for the coordinate that lies outside.
     
     - parameter cropFrame A rectangle representing the crop frame to check.
     
     - returns: returns the input rectangle unchanged if all the dimensions fall within the image frame; otherwise, a rectangle where the coordinate falling outside the image frame is reset to fall on the boundary.
     */
    func restrictDragWithinFrame(cropFrame: CGRect) -> CGRect {
        
        var restrictedFrame = cropFrame
        
        
        /* if the origin's y coordinate falls outside the image frame, then move it to the boundary and reduce the height by the number of pixels it falls outside the frame.
         */
        if restrictedFrame.origin.y < 0 {
            
            restrictedFrame.size.height += restrictedFrame.origin.y
            
            restrictedFrame.origin.y = 0
            
        }
        
        /* if the bottom right corner's y coordinate falls outside the image frame, then move it to the boundary and reduce the height by the number of pixels it falls outside the frame.
         */
        if (restrictedFrame.origin.y + restrictedFrame.height) > frame.height {
            
            restrictedFrame = CGRectMake(restrictedFrame.origin.x, restrictedFrame.origin.y, restrictedFrame.width, frame.height - restrictedFrame.origin.y)
            
        }
        
        /* if the origin's x coordinate falls outside the image frame, then move it to the boundary and reduce the height by the number of pixels it falls outside the frame.
         */
        if restrictedFrame.origin.x < 0 {
            
            restrictedFrame.size.width += restrictedFrame.origin.x
            
            restrictedFrame.origin.x = 0
            
        }
        
        /* if the bottom right corner's x coordinate falls outside the image frame, then move it to the boundary and reduce the width by the number of pixels it falls outside the frame.
         */
        if (restrictedFrame.origin.x + restrictedFrame.width) > frame.width {
            
            restrictedFrame = CGRectMake(restrictedFrame.origin.x, restrictedFrame.origin.y, frame.width - restrictedFrame.origin.x, restrictedFrame.height)
            
        }
        
        return restrictedFrame
        
    }
    
    // MARK: - Managing view hierarchy
    
    func addGesturesToView (view:UIView) -> Void {
        
        /* initialize the scale gesture, and add it to the subview.  The scale gesture is a pinch gesture.
         */
        let scaleGesture = UIPinchGestureRecognizer()
        
        scaleGesture.addTarget(self, action: #selector(MMSLayeredView.scaleView(_:)))
        
        scaleGesture.delegate = self
        
        view.addGestureRecognizer(scaleGesture)
        
        /* initialize the pan gesture, add it to the subview.  Depending on the type of focus, the pan gesture is interpreted as resizing or moving the view.
         */
        let panGesture = UIPanGestureRecognizer()
        
        panGesture.addTarget(self, action: #selector(MMSLayeredView.panView(_:)))
        
        panGesture.delegate = self
        
        panGesture.minimumNumberOfTouches = 1
        
        panGesture.maximumNumberOfTouches = 1
        
        view.addGestureRecognizer(panGesture)
        
        /* initialize the focus gesture, add it to the subview.  The focus gesture is used by the application to direct operations to one of the layered views.  A single tap interprets the following pan gesture as a resize gesture.
         */
        let sizeFocusGesture = UITapGestureRecognizer()
        
        sizeFocusGesture.addTarget(self, action: #selector(MMSLayeredView.toggleFocus(_:)))
        
        sizeFocusGesture.delegate = self
        
        view.addGestureRecognizer(sizeFocusGesture)
        
        /* initialize a double tap focus gesture, add it to the subview.  The double tap focus gesture is used by the application to interpret the following pan gesture as a move gesture.
         */

        let moveFocusGesture = UITapGestureRecognizer()
        
        moveFocusGesture.numberOfTapsRequired = 2
        
        moveFocusGesture.addTarget(self, action: #selector(MMSLayeredView.moveFocus(_:)))
        
        moveFocusGesture.delegate = self
        
        view.addGestureRecognizer(moveFocusGesture)

    }
    
    
    /**
     All the view hierarchy management methods are overriden to add the gestures to the new subview.
     
     */
    
    override public func addSubview(view: UIView) {
        
        addGesturesToView(view)
        
        super.addSubview(view)
        
    }
    
    override public func insertSubview(view: UIView, atIndex index: Int) {
        
        addGesturesToView(view)
        
        super.insertSubview(view, atIndex: index)
        
    }
    
    override public func insertSubview(view: UIView, aboveSubview siblingSubview: UIView) {
        
        addGesturesToView(view)
        
        super.insertSubview(view, aboveSubview: siblingSubview)
    }
    
    override public func insertSubview(view: UIView, belowSubview siblingSubview: UIView) {
        
        addGesturesToView(view)
        
        super.insertSubview(view, aboveSubview: siblingSubview)
        
    }
    
    // MARK: - Public Interface
    
    /**
     Places the view in the bottom of the z-order.  The background view does not receive any input gestures.  The background view is resized to the dimensions of the containing view.
     
     - parameter backgroundView: The view to assign to the background
     
     */
    public func addBackgroundView(backgroundView:UIView) -> Void {
        
        
        // Enable user interaction
        backgroundView.userInteractionEnabled = true
        
        backgroundView.frame = CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height)
        
        super.insertSubview(backgroundView, atIndex: 0)
        
        backgroundView.layer.addSublayer(maskLayer)
        
        /* initialize the focus gesture, add it to the subview.  The focus gesture is used by the application to direct operations to one of the layered views.
         */
        let focusGesture = UITapGestureRecognizer()
        
        focusGesture.addTarget(self, action: #selector(MMSLayeredView.toggleFocus(_:)))
        
        focusGesture.delegate = self
        
        backgroundView.addGestureRecognizer(focusGesture)

        // the background view has default focus
        viewWithFocus = backgroundView
        
    }
    /**
     Returns the view that is set as the background view.  The background view can be replaced by first removing it and then adding the new one.
     
     - returns Background view
     */
    public func getBackgroundView() -> UIView {
        
        return subviews[0]
        
    }
    
    /**
     Removes the subview at index zero which is assumed to be the background view.
     */
    public func removeBackgroundView() -> Void {
        
        if subviews.count > 0 {
            subviews[0].removeFromSuperview()
        }
        
    }
    
    /**
     Merges all the layers into a single UIImage
     
     - returns: UIImage with merged layers
     */
    public func mergeTextAndImage() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        return img
        
    }

}
