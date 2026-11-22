//
//  ChannelDetailItemTests.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/22/26
//

import Foundation
import Testing
@testable import TikiliveCore

@Suite
struct ChannelDetailItemTests {

    @Test
    func streamURLUsesHLS() {
        // Arrange
        let detail = ChannelDetail(
            id: 123,
            name: "Discovery Channel",
            description: "TV channel",
            hasAccess: true,
            sources: ChannelSources(
                hls: "https://example.com/live.m3u8"
            ),
            previewHLSStream: nil,
            freePreview: "no",
            membershipRequired: "no",
            membershipRequiredMessage: "",
            isHD: true,
            dvr: false,
            liveDvr: false
        )

        // Act
        let item = ChannelDetailItem(channelDetails: detail)

        // Assert
        #expect(item.streamURL == URL(string: "https://example.com/live.m3u8"))
    }

    @Test
    func streamURLFallsBackToPreview() {
        // Arrange
        let detail = ChannelDetail(
            id: 123,
            name: "Discovery Channel",
            description: "TV channel",
            hasAccess: false,
            sources: nil,
            previewHLSStream: "https://example.com/preview.m3u8",
            freePreview: "yes",
            membershipRequired: "yes",
            membershipRequiredMessage: "Subscribe to watch the full channel",
            isHD: true,
            dvr: false,
            liveDvr: false
        )

        // Act
        let item = ChannelDetailItem(channelDetails: detail)

        // Assert
        #expect(item.streamURL == URL(string: "https://example.com/preview.m3u8"))
    }

    @Test
    func streamURLPrefersHLSOverPreview() {
        // Arrange
        let detail = ChannelDetail(
            id: 123,
            name: "Discovery Channel",
            description: "TV channel",
            hasAccess: true,
            sources: ChannelSources(
                hls: "https://example.com/live.m3u8"
            ),
            previewHLSStream: "https://example.com/preview.m3u8",
            freePreview: "no",
            membershipRequired: "no",
            membershipRequiredMessage: "",
            isHD: true,
            dvr: false,
            liveDvr: false
        )

        // Act
        let item = ChannelDetailItem(channelDetails: detail)

        // Assert
        #expect(item.streamURL == URL(string: "https://example.com/live.m3u8"))
    }

    @Test
    func streamURLIsNilWithoutStreamAndPreview() {
        // Arrange
        let detail = ChannelDetail(
            id: 123,
            name: "Discovery Channel",
            description: "TV channel",
            hasAccess: false,
            sources: nil,
            previewHLSStream: nil,
            freePreview: "no",
            membershipRequired: "yes",
            membershipRequiredMessage: "Subscribe to watch the full channel",
            isHD: true,
            dvr: false,
            liveDvr: false
        )

        // Act
        let item = ChannelDetailItem(channelDetails: detail)

        // Assert
        #expect(item.streamURL == nil)
    }
}
