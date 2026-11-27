//
//  PlayerViewModel.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/26/26
//

import AVFoundation
import Observation
import Combine

@MainActor
@Observable
public final class PlayerViewModel {
    public private(set) var isLoading = false
    public private(set) var errorMessage: String?

    @ObservationIgnored
    private var statusSubscription: AnyCancellable?

    @ObservationIgnored
    private var itemStatusSubscription: AnyCancellable?

    public let player: AVPlayer = {
        let player = AVPlayer()
        // TODO: dev only, remove before release
        player.isMuted = true
        return player
    }()

    init() {
        observePlayerStatus()
    }

    public func play() {
        player.play()
    }

    public func pause() {
        player.pause()
    }

    public func clear() {
        itemStatusSubscription = nil
        player.replaceCurrentItem(with: nil)
        errorMessage = nil
    }

    public func load(url: URL) {
        itemStatusSubscription = nil

        let item = AVPlayerItem(url: url)

        player.replaceCurrentItem(with: item)

        observeItemStatus(item)
    }

    private func observeItemStatus(_ item: AVPlayerItem) {
        itemStatusSubscription = item
            .publisher(for: \.status)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                if status == .failed {
                    self?.isLoading = false
                    self?.errorMessage = "Stream unavailable"
                }
            }
    }

    public func resume() {
        guard player.currentItem != nil else {
            return
        }

        play()
    }

    public func setLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }

    private func observePlayerStatus() {
        statusSubscription = player
            .publisher(for: \.timeControlStatus)
            // DispatchQueue.main keeps delivering while the list scrolls, RunLoop.main does not
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                if status == .playing {
                    self?.isLoading = false
                }
            }
    }
}
