//
//  ChannelItemTests.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/3/26
//

import Foundation
import Testing

@testable import TikiliveCore

@Suite
struct ChannelItemTests {

    // MARK: - Test Data

    private func makeChannel(img: ChannelImage? = nil) -> Channel {
        Channel(
            id: 123,
            name: "Discovery Channel",
            stbNumber: 7,
            category: nil,
            img: img,
            live: true,
            isCatchupTV: false,
            isHD: true,
            isAdult: false,
            dvr: false,
            channelType: nil,
            tveURL: nil,
            tveProgramID: nil
        )
    }

    // MARK: - Tests

    @Test
    func mapsChannelFields() {
        // Arrange
        let channel = makeChannel(img: ChannelImage(small: "https://example.com/logo.png"))

        // Act
        let item = ChannelItem(channel: channel)

        // Assert
        #expect(item.id == 123)
        #expect(item.number == "7")
        #expect(item.name == "Discovery Channel")
        #expect(item.logoURL == URL(string: "https://example.com/logo.png"))
        #expect(item.isLive)
    }

    @Test
    func logoURLIsNilWithoutImage() {
        // Arrange
        let channel = makeChannel()

        // Act
        let item = ChannelItem(channel: channel)

        // Assert
        #expect(item.logoURL == nil)
    }

    @Test
    func logoURLIsNilWithoutSmallImage() {
        // Arrange
        let channel = makeChannel(img: ChannelImage(small: nil))

        // Act
        let item = ChannelItem(channel: channel)

        // Assert
        #expect(item.logoURL == nil)
    }
}
