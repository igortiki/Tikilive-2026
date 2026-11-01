//
//  ChannelsResponse.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/1/26
//


import Foundation

struct ChannelsResponse: Decodable {
    let status: Int
    let channels: [Channel]
}
