//
//  AppDependencies.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/11/26
//

public final class AppDependencies {
    private let apiClient: APIClient
   
    public init(configuration: APIConfiguration) {
        self.apiClient = APIClient(configuration: configuration)
    }
    
    public func makeChannelListViewModel() -> ChannelListViewModel {
        let channelService = ChannelService(client: apiClient)
        let viewModel = ChannelListViewModel(service: channelService)
        return viewModel
    }
}
