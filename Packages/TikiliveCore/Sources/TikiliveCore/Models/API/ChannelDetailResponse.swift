//
//  ChannelDetailResponse.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/17/26
//

import Foundation

struct ChannelDetailResponse: Decodable {
    let status: Int
    let channel: ChannelDetail
}

struct ChannelDetail: Decodable {
    let id: Int
    let name: String
    let description: String

    let hasAccess: Bool
    // absent when the guest has no access to the channel
    let sources: ChannelSources?
    // present only on locked channels that offer a free preview
    let previewHLSStream: String?

    // the API sends "yes" / "no" strings
    let freePreview: String
    let membershipRequired: String
    let membershipRequiredMessage: String

    let isHD: Bool
    let dvr: Bool
    let liveDvr: Bool

    var isFreePreview: Bool {
        freePreview == "yes"
    }

    var isMembershipRequired: Bool {
        membershipRequired == "yes"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description

        case hasAccess = "has_access"
        case sources
        case previewHLSStream = "preview_hls_stream"

        case freePreview = "free_preview"
        case membershipRequired = "membership_required"
        case membershipRequiredMessage = "membership_required_message"

        case isHD = "is_hd"
        case dvr
        case liveDvr = "live_dvr"
    }
}

struct ChannelSources: Decodable {
    let hls: String
}
