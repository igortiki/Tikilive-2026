//
//  AppDependencies.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/11/26
//

public final class AppDependencies {
    private let apiClient: APIClient

    @MainActor
    public init(configuration: APIConfiguration) {
        self.apiClient = APIClient(configuration: configuration)
    }
    
    @MainActor
    public func makeChannelListViewModel() -> ChannelListViewModel {
        let channelService = ChannelService(client: apiClient)
        let viewModel = ChannelListViewModel(service: channelService)
        return viewModel
    }
    
    @MainActor
    public func makeChannelDetailViewModel() -> ChannelDetailViewModel {
        let channelService = ChannelService(client: apiClient)
        let viewModel = ChannelDetailViewModel(service: channelService)
        return viewModel
    }
}
