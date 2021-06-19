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
		guard let hand = hand else {return false}
		for playerCard in hand {
			if playerCard.value == card.value {
				return true
			}
		}
		return false
	}

	func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
		guard let hand = hand else {return false}
		for playerCard in hand {
			for item in table {
				if playerCard.value == item.key.value ||
				   playerCard.value == item.value.value
				{
					return true
				}
			}
		}
		return false
	}
}
