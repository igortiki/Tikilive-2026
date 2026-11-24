//
//  ChannelDetailViewModel.swift.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/21/26
//

import Foundation

@MainActor
@Observable

public final class ChannelDetailViewModel {
    private let service: any ChannelServiceProtocol
    public private(set) var errorMessage: String?
    public private(set) var channelDetail: ChannelDetailItem?
    
    init(service: any ChannelServiceProtocol) {
        self.service = service
    }
    
    // UIKit-style alternative to LiveView's .task(id:): manual Task ownership, cancel on reselect
    // private var loadTask: Task<Void, Never>?
    //
    // public var selectedChannelID: Int? {
    //     didSet {
    //         loadTask?.cancel()
    //
    //         guard let id = selectedChannelID else {
    //             loadTask = nil
    //             return
    //         }
    //
    //         loadTask = Task {
    //             await fetchChannelDetails(id: id)
    //         }
    //     }
    // }
    
    public func fetchChannelDetails(id: Int) async {
        // drop the previous channel so a failed load can't replay its stream
        channelDetail = nil
        errorMessage = nil
        
        do {
            let response = try await service.fetchChannelInfo(channelID: id)
            try Task.checkCancellation()
            channelDetail = ChannelDetailItem(channelDetails: response)
        } catch is CancellationError, URLError.cancelled {
            // cancelled by the view, not a real error
        } catch {
            guard !Task.isCancelled else { return }
            errorMessage = error.localizedDescription
        }
    }
}



