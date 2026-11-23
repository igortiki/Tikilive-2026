//
//  ChannelDetailViewModelTests.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/22/26
//

import Foundation
import Testing
@testable import TikiliveCore

@Suite
struct ChannelDetailViewModelTests {

    @Test
    @MainActor
    func fetchChannelDetailsSuccess() async throws {
        // Arrange
        let detail = ChannelDetail(
            id: 123,
            name: "Discovery Channel",
            description: "TV channel",
            hasAccess: true,
            sources: ChannelSources(hls: "https://example.com/discovery.m3u8"),
            previewHLSStream: nil,
            freePreview: "no",
            membershipRequired: "no",
            membershipRequiredMessage: "",
            isHD: true,
            dvr: false,
            liveDvr: false
        )
        let mockService = MockChannelService(channels: [], channelDetail: detail)
        let viewModel = ChannelDetailViewModel(service: mockService)

        // Act
        await viewModel.fetchChannelDetails(id: 123)

        // Assert
        #expect(viewModel.channelDetail?.id == 123)
        #expect(viewModel.channelDetail?.name == "Discovery Channel")
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    @MainActor
    func fetchChannelDetailsFailure() async throws {
        // Arrange
        let expectedError = URLError(.notConnectedToInternet)
        let mockService = MockChannelService(channels: [], error: expectedError)
        let viewModel = ChannelDetailViewModel(service: mockService)

        // Act
        await viewModel.fetchChannelDetails(id: 123)

        // Assert
        #expect(viewModel.channelDetail == nil)
        #expect(viewModel.errorMessage == expectedError.localizedDescription)
    }

    @Test
    @MainActor
    func fetchChannelDetailsFailureClearsPreviousChannel() async throws {
        // Arrange
        let detail = ChannelDetail(
            id: 123,
            name: "Discovery Channel",
            description: "TV channel",
            hasAccess: true,
            sources: ChannelSources(hls: "https://example.com/discovery.m3u8"),
            previewHLSStream: nil,
            freePreview: "no",
            membershipRequired: "no",
            membershipRequiredMessage: "",
            isHD: true,
            dvr: false,
            liveDvr: false
        )
        let mockService = MockChannelService(channels: [], channelDetail: detail)
        let viewModel = ChannelDetailViewModel(service: mockService)

        await viewModel.fetchChannelDetails(id: 123)
        #expect(viewModel.channelDetail?.id == 123)

        // Act
        await viewModel.fetchChannelDetails(id: 456)

        // Assert
        #expect(viewModel.channelDetail == nil)
    }

    @Test
    @MainActor
    func fetchChannelDetailsIgnoresCancellationError() async throws {
        // Arrange
        let cancellationError = CancellationError()
        let mockService = MockChannelService(channels: [], error: cancellationError)
        let viewModel = ChannelDetailViewModel(service: mockService)

        // Act
        await viewModel.fetchChannelDetails(id: 123)

        // Assert
        #expect(viewModel.channelDetail == nil)
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    @MainActor
    func fetchChannelDetailsIgnoresURLCancelled() async throws {
        // Arrange
        let cancellationError = URLError(.cancelled)
        let mockService = MockChannelService(channels: [], error: cancellationError)
        let viewModel = ChannelDetailViewModel(service: mockService)

        // Act
        await viewModel.fetchChannelDetails(id: 123)

        // Assert
        #expect(viewModel.channelDetail == nil)
        #expect(viewModel.errorMessage == nil)
    }
}
