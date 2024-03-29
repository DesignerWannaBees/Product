//
//  QuickStartViewController.swift
//  fireworks
//
//  Created by Micaela Cavallo on 20/11/2019.
//  Copyright © 2019 Terrence Gillespie. All rights reserved.
//

import UIKit

class QuickStartViewController: UIViewController {
    
    var quickstartChallenge : Challenge!

    @IBOutlet weak var goLabel: UILabel!
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var tappingLabel: UILabel!
    @IBOutlet weak var wideScreenButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if quickstartChallenge != nil {
            iconImageView.image = UIImage(named: quickstartChallenge.quickImage)
        } else {
             iconImageView.image = #imageLiteral(resourceName: "quick-walk-icon")
        }
    }
    @IBAction func tapWideStartButton(_ sender: Any) {
        
        //trigger the counting functions
    }
    
    @IBAction func tapHare(_ sender: UIBarButtonItem) {
        
        //go into a controller that allows changing user preferences
    }
    
    @IBAction func triggerCongratulationsModal(_ sender: Any) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "congratsVC2") as? CongratsViewController
        {
            present(vc, animated: true, completion: nil)
        }
    }
    
}
