//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?

	func checkIfCanTossWhenAttacking(card: Card) -> Bool {
		if hand != nil {
			return hand?.first {$0.value == card.value} != nil
		}
		return false
	}

	func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
		for item in table {
			if checkIfCanTossWhenAttacking(card: item.key) ||
			   checkIfCanTossWhenAttacking(card: item.value)
			{
				return true
			}
		}
		return false
	}
}
