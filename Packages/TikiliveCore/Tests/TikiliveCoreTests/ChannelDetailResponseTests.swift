//
//  ChannelDetailResponseTests.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/17/26
//

import Foundation
import Testing

@testable import TikiliveCore

@Suite
struct ChannelDetailResponseTests {

    @Test
    func decodeChannelWithAccess() throws {
        // Arrange
        // Neighbouring flags alternate so a swapped CodingKey fails the test
        let json = """
        {
            "status": 200,
            "channel": {
                "id": 58039,
                "name": "Law and Crime",
                "description": "True crime 24/7",
                "has_access": true,
                "sources": { "hls": "https://example.com/live.m3u8", "rtmp": "rtmp://example.com/live" },
                "free_preview": "no",
                "membership_required": "yes",
                "membership_required_message": "Membership required",
                "is_hd": true,
                "dvr": false,
                "live_dvr": true
            }
        }
        """

        let jsonData = Data(json.utf8)

        // Act
        let response = try JSONDecoder().decode(ChannelDetailResponse.self, from: jsonData)

        // Assert
        let channel = response.channel
        #expect(channel.id == 58039)
        #expect(channel.name == "Law and Crime")
        #expect(channel.description == "True crime 24/7")
        #expect(channel.hasAccess)
        #expect(channel.sources?.hls == "https://example.com/live.m3u8")
        #expect(channel.previewHLSStream == nil)
        #expect(!channel.isFreePreview)
        #expect(channel.isMembershipRequired)
        #expect(channel.membershipRequiredMessage == "Membership required")
        #expect(channel.isHD)
        #expect(!channel.dvr)
        #expect(channel.liveDvr)
    }

    @Test
    func decodeLockedChannelWithPreview() throws {
        // Arrange
        // the server omits "sources" when the guest has no access
        let json = """
        {
            "status": 200,
            "channel": {
                "id": 58526,
                "name": "AWE",
                "description": "",
                "has_access": false,
                "preview_hls_stream": "https://example.com/preview.m3u8",
                "free_preview": "yes",
                "membership_required": "no",
                "membership_required_message": "Membership required",
                "is_hd": false,
                "dvr": false,
                "live_dvr": false
            }
        }
        """

        let jsonData = Data(json.utf8)

        // Act
        let response = try JSONDecoder().decode(ChannelDetailResponse.self, from: jsonData)

        // Assert
        let channel = response.channel
        #expect(channel.id == 58526)
        #expect(!channel.hasAccess)
        #expect(channel.sources == nil)
        #expect(channel.previewHLSStream == "https://example.com/preview.m3u8")
        #expect(channel.isFreePreview)
        #expect(!channel.isMembershipRequired)
    }
}
