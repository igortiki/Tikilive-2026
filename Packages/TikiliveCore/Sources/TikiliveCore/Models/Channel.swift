//
//  Channel.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/1/26
//

import Foundation

struct Channel: Decodable, Identifiable {

    let id: Int
    let name: String
    let stbNumber: Int

    let category: ChannelCategory?
    let img: ChannelImage?

    let live: Bool
    let isCatchupTV: Bool
    let isHD: Bool
    let isAdult: Bool
    let dvr: Bool

    let channelType: String?
    let tveURL: String?
    let tveProgramID: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case stbNumber = "stb_number"

        case category
        case img

        case live
        case isCatchupTV = "is_catchup_tv"
        case isHD = "is_hd"
        case isAdult = "is_adult"
        case dvr

        case channelType = "channel_type"
        case tveURL = "tve_url"
        case tveProgramID = "tve_program_id_ios"
    }
}

struct ChannelCategory: Decodable {
    let id: Int
}

struct ChannelImage: Decodable {
    let small: String?
}
