//
//  PickerOptionsDelegate.swift
//  guest-list
//
//  Created by Mattias Tilert Thunqvist on 2020-05-07.
//  Copyright © 2020 Mattias Tilert Thunqvist. All rights reserved.
//

import Foundation

protocol PickerOptionsDelegate {
    func pickerOptions(_ pickerOption: PickerOptions, didSelectRowAtIndex row: Int)
}
