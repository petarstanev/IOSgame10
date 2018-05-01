//
//  VibrationHelper.swift
//  Game 8
//
//  Created by Petar Stanev on 01/05/2018.
//  Copyright © 2018 Petar Stanev. All rights reserved.
//

import Foundation
import AudioToolbox

class VibrationHelper {
    func vibrate() {
        //print("vibration")
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
