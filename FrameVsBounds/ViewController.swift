//
//  ViewController.swift
//  FrameVsBounds
//
//  Created by Evgenii Semenov on 22.01.2020.
//  Copyright © 2020 Evgenii Semenov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myView: UIScrollView!
    
    // Labels
    @IBOutlet weak var frameX: UILabel!
    @IBOutlet weak var frameY: UILabel!
    @IBOutlet weak var frameWidth: UILabel!
    @IBOutlet weak var frameHeight: UILabel!
    @IBOutlet weak var boundsX: UILabel!
    @IBOutlet weak var boundsY: UILabel!
    @IBOutlet weak var boundsWidth: UILabel!
    @IBOutlet weak var boundsHeight: UILabel!
    @IBOutlet weak var centerX: UILabel!
    @IBOutlet weak var centerY: UILabel!
    @IBOutlet weak var rotation: UILabel!
    
    // Sliders
    @IBOutlet weak var frameXSlider: UISlider!
    @IBOutlet weak var frameYSlider: UISlider!
    @IBOutlet weak var frameWidthSlider: UISlider!
    @IBOutlet weak var frameHeightSlider: UISlider!
    @IBOutlet weak var boundsXSlider: UISlider!
    @IBOutlet weak var boundsYSlider: UISlider!
    @IBOutlet weak var boundsWidthSlider: UISlider!
    @IBOutlet weak var boundsHeightSlider: UISlider!
    @IBOutlet weak var centerXSlider: UISlider!
    @IBOutlet weak var centerYSlider: UISlider!
    @IBOutlet weak var rotationSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        [frameX, frameY, frameWidth, frameHeight, boundsX, boundsY, boundsWidth, boundsHeight, centerX, centerY, rotation].forEach { label in
            label?.textColor = .black
        }
        myView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialView()
        updateLabels()
        initialSliders()
    }
    
    // Slider actions
    @IBAction func frameXSliderChanged(sender: AnyObject) {
        myView.frame.origin.x = CGFloat(frameXSlider.value)
        centerXSlider.value = Float(myView.center.x)
        updateLabels()
    }
    @IBAction func frameYSliderChanged(sender: AnyObject) {
        myView.frame.origin.y = CGFloat(frameYSlider.value)
        centerYSlider.value = Float(myView.center.y)
        updateLabels()
    }
    @IBAction func frameWidthSliderChanged(sender: AnyObject) {
        myView.frame.size.width = CGFloat(frameWidthSlider.value)
        boundsWidthSlider.value = Float(myView.bounds.size.width)
        centerXSlider.value = Float(myView.center.x)
        updateLabels()
    }
    @IBAction func frameHeightSliderChanged(sender: AnyObject) {
        myView.frame.size.height = CGFloat(frameHeightSlider.value)
        boundsHeightSlider.value = Float(myView.bounds.size.height)
        centerYSlider.value = Float(myView.center.y)
        updateLabels()
    }
    @IBAction func boundsXSliderChanged(sender: AnyObject) {
        myView.bounds.origin.x = CGFloat(boundsXSlider.value)
        updateLabels()
    }
    @IBAction func boundsYSliderChanged(sender: AnyObject) {
        myView.bounds.origin.y = CGFloat(boundsYSlider.value)
        updateLabels()
    }
    @IBAction func boundsWidthSliderChanged(sender: AnyObject) {
        myView.bounds.size.width = CGFloat(boundsWidthSlider.value)
        frameWidthSlider.value = Float(myView.frame.size.width)
        frameXSlider.value = Float(myView.frame.origin.x)
        updateLabels()
    }
    @IBAction func boundsHeightSliderChanged(sender: AnyObject) {
        myView.bounds.size.height = CGFloat(boundsHeightSlider.value)
        frameHeightSlider.value = Float(myView.frame.size.height)
        frameYSlider.value = Float(myView.frame.origin.y)
        updateLabels()
    }
    @IBAction func centerXSliderChanged(sender: AnyObject) {
        myView.center.x = CGFloat(centerXSlider.value)
        frameXSlider.value = Float(myView.frame.origin.x)
        frameWidthSlider.value = Float(myView.frame.size.width)
        updateLabels()
    }
    @IBAction func centerYSliderChanged(sender: AnyObject) {
        myView.center.y = CGFloat(centerYSlider.value)
        frameYSlider.value = Float(myView.frame.origin.y)
        frameHeightSlider.value = Float(myView.frame.size.height)
        updateLabels()
    }
    @IBAction func rotationSliderChanged(sender: AnyObject) {
        let rotation = CGAffineTransform(rotationAngle: CGFloat(rotationSlider.value) / 180 * .pi)
        myView.transform = rotation
        frameXSlider.value = Float(myView.frame.origin.x)
        frameYSlider.value = Float(myView.frame.origin.y)
        frameHeightSlider.value = Float(myView.frame.size.height)
        frameWidthSlider.value = Float(myView.frame.size.width)
        updateLabels()
    }
    
    private func updateLabels() {
        var frameString = "frame"
        var boundsString = "bounds"
        if (view.bounds.width <= 414) {
            frameString = "fr."
            boundsString = "b."
        }
        
        frameX.text = "frame x = \(Int(myView.frame.origin.x))"
        frameY.text = "frame y = \(Int(myView.frame.origin.y))"
        frameWidth.text = "\(frameString) width = \(Int(myView.frame.width))"
        frameHeight.text = "\(frameString) height = \(Int(myView.frame.height))"
        boundsX.text = "bounds x = \(Int(myView.bounds.origin.x))"
        boundsY.text = "bounds y = \(Int(myView.bounds.origin.y))"
        boundsWidth.text = "\(boundsString) width = \(Int(myView.bounds.width))"
        boundsHeight.text = "\(boundsString) height = \(Int(myView.bounds.height))"
        centerX.text = "center x = \(Int(myView.center.x))"
        centerY.text = "center y = \(Int(myView.center.y))"
        rotation.text = "rotation = \(Int(rotationSlider.value))"
    }
    
    private func initialSliders() {
        frameXSlider.minimumValue = -300
        frameXSlider.maximumValue = Float(view.frame.width)
        frameYSlider.minimumValue = -300
        frameYSlider.maximumValue = Float(view.frame.height)
        frameWidthSlider.maximumValue = 300
        frameHeightSlider.maximumValue = 300
        boundsXSlider.minimumValue = -Float(view.frame.width)
        boundsXSlider.maximumValue = Float(view.frame.width)
        boundsYSlider.minimumValue = -Float(view.frame.width)
        boundsYSlider.maximumValue = Float(view.frame.width)
        boundsWidthSlider.maximumValue = 100
        boundsHeightSlider.maximumValue = 100
        centerXSlider.maximumValue = Float(view.frame.width)
        centerYSlider.maximumValue = Float(view.frame.height)
        rotationSlider.maximumValue = 360
    }
    
    private func initialView() {
        myView.layer.borderWidth = 2
        myView.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        myView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        myView.frame.origin.x = 100
        myView.frame.origin.y = 100
        myView.frame.size.width = 100
        myView.frame.size.height = 100
        myView.bounds.origin.x = 0
        myView.bounds.origin.y = 0
        myView.bounds.size.width = 100
        myView.bounds.size.height = 100
        myView.center.x = 150
        myView.center.y = 150
        myView.transform = CGAffineTransform(rotationAngle: 0)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        boundsXSlider.value = Float(myView.bounds.origin.x)
        boundsYSlider.value = Float(myView.bounds.origin.y)
        updateLabels()
    }
}
