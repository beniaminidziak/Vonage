//
//  Safe.swift
//  Vonage
//
//  Created by Beniamin Idziak on 15/01/2026.
//

actor Safe<Key: Hashable, Value> {
    private var storage: [Key: Value]

    init(storage: [Key : Value] = [:]) {
        self.storage = storage
    }

    func get(_ key: Key) -> Value? { storage[key] }
    func set(_ value: Value?, for key: Key) { storage[key] = value }
}
