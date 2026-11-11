//
//  AppDependencies.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/11/26
//

public final class AppDependencies {
    private let apiClient: APIClient
   
    public init() {
        self.apiClient = APIClient(configuration: .tiki6)
    }
    
    public func makeChannelListViewModel() -> ChannelListViewModel {
        let channelService = ChannelService(client: apiClient)
        let viewModel = ChannelListViewModel(service: channelService)
        return viewModel
    }
}
