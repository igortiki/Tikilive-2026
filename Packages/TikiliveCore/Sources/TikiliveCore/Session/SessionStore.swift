//
//  SessionStore.swift
//  TikiliveCore
//
//  Created by Igor Malasevschi on 11/27/26
//

// stub: always a guest until login exists
public final class SessionStore {

    private(set) var authKey: String?

    public var isAuthenticated: Bool {
        authKey != nil
    }
}
