//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

	func defineFirstAttackingPlayer(players: [Player]) -> Player? {
		var firstAttackingPlayer: Player?
		var minTrumpCard: Card?
		for player in players {
			guard let hand = player.hand else {continue}
			for card in hand {
				if card.isTrump && card.value < minTrumpCard?.value ?? .ace {
					minTrumpCard = card
					firstAttackingPlayer = player
				}
			}
		}
		return firstAttackingPlayer
	}
}
