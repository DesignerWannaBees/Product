//
//  ArrayExtension.swift
//  fireworks
//
//  Created by Micaela Cavallo on 24/11/2019.
//  Copyright © 2019 Terrence Gillespie. All rights reserved.
//

import Foundation

extension Array {
    func safeValue(at index: Int) -> Element? {
        if index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
}
