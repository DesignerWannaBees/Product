//
//  UIBezierPathExtension.swift
//  fireworks
//
//  Created by Micaela Cavallo on 24/11/2019.
//  Copyright © 2019 Terrence Gillespie. All rights reserved.
//

import UIKit

extension UIBezierPath {
    convenience init(curvedSegment: CurvedSegment) {
        self.init()
        self.move(to: curvedSegment.startPoint)
        self.addCurve(to: curvedSegment.toPoint, controlPoint1: curvedSegment.controlPoint1, controlPoint2: curvedSegment.controlPoint2)
        self.addLine(to: curvedSegment.endPoint)
    }
    
    convenience init(lineSegment: LineSegment) {
        self.init()
        self.move(to: lineSegment.startPoint)
        self.addLine(to: lineSegment.endPoint)
    }
}
