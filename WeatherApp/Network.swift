//
//  Network.swift
//  WeatherApp
//
//  Created by Aybek Can Kaya on 8.07.2021.
//

import Foundation
import Combine
import Reachability

enum NetworkConnectionStatus {
    case unknown
    case offline
    case online
}

class Network {
    static let shared = Network()
    private let reachability = try! Reachability()
    
    private(set) var networkStatus = CurrentValueSubject<NetworkConnectionStatus, Never>(.unknown)
    
    init() {
        addListeners()
        startNetworkNotifier()
    }
    
    deinit {
        
    }
    
    private func startNetworkNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func addListeners() {
        reachability.whenReachable = { reachability in
            self.networkStatus.send(.online)
        }
        reachability.whenUnreachable = { _ in
            self.networkStatus.send(.offline)
        }
    }
}
