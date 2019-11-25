//
//  DataEntry.swift
//  fireworks
//
//  Created by Micaela Cavallo on 24/11/2019.
//  Copyright © 2019 Terrence Gillespie. All rights reserved.
//

import Foundation
import UIKit

struct DataEntry {
    let color: UIColor
    
    /// Ranged from 0.0 to 1.0
    let height: Float
    
    /// To be shown on top of the bar
    let textValue: String
    
    /// To be shown at the bottom of the bar
    let title: String
}
