//
//  ChannelTests.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/2/26
//

import Foundation
import Testing

@testable import TikiliveCore

@Suite
struct ChannelTests {

    @Test
    func decodeValidChannel() throws {
        // Arrange
        // Neighbouring flags alternate so a swapped CodingKey fails the test
        let json = """
        {
            "id": 123,
            "name": "Discovery Channel",
            "stb_number": 7,
            "category": { "id": 10 },
            "img": { "small": "https://example.com/logo.png" },
            "live": true,
            "is_catchup_tv": false,
            "is_hd": true,
            "is_adult": false,
            "dvr": true,
            "channel_type": "tv",
            "tve_url": "https://example.com/stream",
            "tve_program_id_ios": "program123"
        }
        """
        
        let jsonData = Data(json.utf8)

        // Act
        let channel = try JSONDecoder().decode(Channel.self, from: jsonData)

        // Assert
        #expect(channel.id == 123)
        #expect(channel.name == "Discovery Channel")
        #expect(channel.stbNumber == 7)
        #expect(channel.category?.id == 10)
        #expect(channel.img?.small == "https://example.com/logo.png")
        #expect(channel.live)
        #expect(!channel.isCatchupTV)
        #expect(channel.isHD)
        #expect(!channel.isAdult)
        #expect(channel.dvr)
        #expect(channel.channelType == "tv")
        #expect(channel.tveURL == "https://example.com/stream")
        #expect(channel.tveProgramID == "program123")
    }

    @Test
    func decodeChannelWithMissingOptionalFields() throws {
        // Arrange
        let json = """
        {
            "id": 123,
            "name": "Discovery Channel",
            "stb_number": 7,
            "live": true,
            "is_catchup_tv": false,
            "is_hd": true,
            "is_adult": false,
            "dvr": false
        }
        """
        let data = Data(json.utf8)

        // Act
        let channel = try JSONDecoder().decode(Channel.self, from: data)

        // Assert
        #expect(channel.category == nil)
        #expect(channel.img == nil)
        #expect(channel.channelType == nil)
        #expect(channel.tveURL == nil)
        #expect(channel.tveProgramID == nil)
    }

    @Test
    func decodeChannelWithNullOptionalFields() throws {
        // Arrange
        let json = """
        {
            "id": 123,
            "name": "Discovery Channel",
            "stb_number": 7,
            "category": null,
            "img": null,
            "live": true,
            "is_catchup_tv": false,
            "is_hd": true,
            "is_adult": false,
            "dvr": false,
            "channel_type": null,
            "tve_url": null,
            "tve_program_id_ios": null
        }
        """
        let data = Data(json.utf8)

        // Act
        let channel = try JSONDecoder().decode(Channel.self, from: data)

        // Assert
        #expect(channel.category == nil)
        #expect(channel.img == nil)
        #expect(channel.channelType == nil)
        #expect(channel.tveURL == nil)
        #expect(channel.tveProgramID == nil)
    }

    @Test
    func decodeChannelWithoutRequiredFieldThrows() throws {
        // Arrange
        let json = """
        {
            "id": 123,
            "name": "Discovery Channel",
            "live": true,
            "is_catchup_tv": false,
            "is_hd": true,
            "is_adult": false,
            "dvr": false
        }
        """
        let data = Data(json.utf8)

        // Act
        let error = try #require(throws: DecodingError.self) {
            try JSONDecoder().decode(Channel.self, from: data)
        }

        // Assert
        guard case .keyNotFound(let key, _) = error else {
            Issue.record("Expected keyNotFound, got \(error)")
            return
        }
        #expect(key.stringValue == "stb_number")
    }
}
