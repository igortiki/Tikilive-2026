//
//  EnvironmentValues+ImageLoader.swift
//  TikiliveUI
//
//  Created by Igor Malasevschi on 11/21/26
//

import SwiftUI

extension EnvironmentValues {
    // Optional: the default is created off the main actor, so it can't be an ImageLoader
    @Entry public var imageLoader: ImageLoader? = nil
}
