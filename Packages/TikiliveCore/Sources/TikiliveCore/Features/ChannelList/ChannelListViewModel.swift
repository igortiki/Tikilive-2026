//
//  ChannelListViewModel.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/3/26
//

public final class ChannelListViewModel {
    
    private let service: any ChannelServiceProtocol
    
    init(service: any ChannelServiceProtocol) {
        self.service = service
    }
}
