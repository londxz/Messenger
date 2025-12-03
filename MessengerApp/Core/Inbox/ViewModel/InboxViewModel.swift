//
//  InboxViewModel.swift
//  MessengerApp
//
//  Created by Родион Холодов on 03.12.2025.
//

import Combine
import Foundation

class InboxViewModel: ObservableObject {
    @Published var user: UserModel?
    private var cancellables = Set<AnyCancellable>()

    init() {
        setSubscribers()
    }

    private func setSubscribers() {
        UserService.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }
}
