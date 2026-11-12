//
//  ChannelListViewModelTests.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/12/26
//


import Foundation
import Testing
@testable import TikiliveCore

@Suite
struct ChannelListViewModelTests {

    @Test
    @MainActor
    func loadChannelsSuccess() async throws {

        // Arrange
        let channels = [
            Channel(
                id: 1,
                name: "News",
                stbNumber: 7,
                category: nil,
                img: nil,
                live: true,
                isCatchupTV: false,
                isHD: true,
                isAdult: false,
                dvr: false,
                channelType: nil,
                tveURL: nil,
                tveProgramID: nil
            ),
            Channel(
                id: 2,
                name: "Sports",
                stbNumber: 7,
                category: nil,
                img: nil,
                live: true,
                isCatchupTV: false,
                isHD: true,
                isAdult: false,
                dvr: false,
                channelType: nil,
                tveURL: nil,
                tveProgramID: nil
            )
        ]
        let channelService = MockChannelService(channels: channels)
        let viewModel = ChannelListViewModel(service: channelService)
       
        // Act
        await viewModel.loadChannels()
       
        // Assert
        #expect(viewModel.channels.map(\.id) == [1, 2])
        #expect(viewModel.channels.map(\.name) == ["News", "Sports"])
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    @MainActor
    func loadChannelsFailure() async throws {

        // Arrange
        let error = URLError(.notConnectedToInternet)
        let channelService = MockChannelService(channels: [], error: error)
        let viewModel = ChannelListViewModel(service: channelService)

        // Act
        await viewModel.loadChannels()

        // Assert
        #expect(viewModel.channels.isEmpty)
        #expect(viewModel.errorMessage == error.localizedDescription)
    }
}
