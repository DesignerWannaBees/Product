//
//  QuickStartViewController.swift
//  fireworks
//
//  Created by Micaela Cavallo on 20/11/2019.
//  Copyright © 2019 Terrence Gillespie. All rights reserved.
//

import UIKit
import CoreMotion

class QuickStartViewController: UIViewController, ImprovedStepCounterDelegate {
    
    var quickstartChallenge : Challenge!

    @IBOutlet weak var goLabel: UILabel!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var tappingLabel: UILabel!
    @IBOutlet weak var wideScreenButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var stepsRemaining: UILabel!
    @IBOutlet weak var progressBarContainer: UIView!
    
    private var progressBar: CircularProgressBar!
    private let improvedSC = ImprovedStepCounter()
    private let STEP_GOAL: Float = 100.0 // The number of steps to reach
    private let PEDOMETER = CMPedometer()
    private let enableAccurateStepCounting = true
    private var stepsDonePreviowsCheck: Float = 0.0
    private var stepsDone: Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepsRemaining.text = String(Int(STEP_GOAL)) // At beginning sets the remaining steps label based on the goal
        progressBar = CircularProgressBar(viewContainer: view) // creates a new object circularProgressBar contained in view
        
        improvedSC.delegate = self
        
        // Setting up the progress bar apparence
        progressBar.createAndShowCircularProgressBar(
            radius: view.frame.width/2 - 45,
            center: view.center,
            startAngle: CGFloat((3*Double.pi)/2),
            progressBarWidth: 17.0,
            progressBarTrackWidth: 17.0,
            progressBarColor: 0x5955cf,      // Main progress bar color
            progressBarTrackColor: 0x5955cf, // Background track bar color
            progressBarColorAlpha: 1.0,      // Main progress bar color alpha
            progressBarTrackColorAlpha: 0.4  // Background track bar color alpha
        )
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startStepCounter)))
        view.isUserInteractionEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if quickstartChallenge != nil {
            iconImageView.image = UIImage(named: quickstartChallenge.quickImage)
        } else {
             iconImageView.image = #imageLiteral(resourceName: "quick-walk-icon")
        }
    }
    
    /**
        Calculates the decimal percentage of the steps done so far considering the step goal.
     
        e.g: 1500 steps done on 5000 steps to reach is 30%, so the function will return 0.3.

        - Parameters:
          - stepsDone: The number of steps done so far
          - stepsGoal: The number of steps to reach
     
        - Returns: The percentage of steps done so far in decimal.
    */
    private func calculateStepsPercentage(_ stepsDone: Float, _ stepsGoal: Float) -> Float {
        return Float(stepsDone / stepsGoal)
    }
    
    /**
     *   Action associated to the view, which will trigger the pedometer
     */
    @objc func startStepCounter() {
        if CMPedometer.isStepCountingAvailable() {
            if enableAccurateStepCounting {
                improvedSC.startStepCount(fps: 60)
            } else {
                PEDOMETER.startUpdates(from: Date(), withHandler: pedometerUpdateHandler)
            }
        }
    }
    
    /**
     * This handler uses the default pedometer "realtime" data from CMPedometer
     */
    func pedometerUpdateHandler(pedometerData: CMPedometerData?, error: Error?) {
        guard let PEDOMETER_DATA = pedometerData, error == nil else { return }
        DispatchQueue.main.async {
            let numberOfStepsSoFar = PEDOMETER_DATA.numberOfSteps.floatValue
            let stepsDonePercentage = self.calculateStepsPercentage(numberOfStepsSoFar, self.STEP_GOAL)
            
            if (numberOfStepsSoFar <= self.STEP_GOAL) {
                let stepsDoneNow = Int(self.stepsRemaining.text!)! - Int(numberOfStepsSoFar - self.stepsDonePreviowsCheck)
                self.stepsRemaining.text = String(stepsDoneNow)
                self.stepsDonePreviowsCheck = numberOfStepsSoFar
                self.progressBar.setProgressWithAnimation(duration: 1.0, value: stepsDonePercentage)
            } else { // updates one last time the arc animation, sets the remaining steps label to 0 and ends the pedometer updates
                self.progressBar.setProgressWithAnimation(duration: 1.0, value: stepsDonePercentage)
                self.stepsRemaining.text = "0"
                self.PEDOMETER.stopUpdates()
                self.showCongratulationsModal()
            }
        }
    }
    @IBAction func tapWideStartButton(_ sender: Any) {
        
        //trigger the counting functions
    }
    
    @IBAction func tapHare(_ sender: UIBarButtonItem) {
        
        //go into a controller that allows changing user preferences
    }
    
    @IBAction func triggerCongratulationsModal(_ sender: Any) {
        showCongratulationsModal()
    }
    
    func showCongratulationsModal() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "congratsVC2") as? CongratsViewController
        {
            present(vc, animated: true, completion: nil)
        }
    }
    
    func stepAccurate() {
        let stepRemainingNow = Int(stepsRemaining.text!)! - 1
        
        if stepRemainingNow >= 0 {
            stepsDone = Float(stepsDone) + 1
            stepsRemaining.text = "\(stepRemainingNow)"
            progressBar.setProgressWithAnimation(duration: 1.0, value: calculateStepsPercentage(stepsDone, STEP_GOAL))
        } else {
            improvedSC.stopAccMeter()
            showCongratulationsModal()
//            stepsRemaining.text = String(Int(STEP_GOAL))
//            progressBar.setProgressWithAnimation(duration: 1.0, value: 0.0)
//            stepsDone = 0.0
        }
     }
    
}
