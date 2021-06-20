import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

	init(with type: DeckType) {
		self.type = type
		switch type {
		case .deck36:
			cards = createDeck(suits: Suit.allCases, values: Value.allCases)
		}
	}

	public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
		var cards: [Card] = []
		let sortedSuits = suits.sorted { $0.rawValue < $1.rawValue }
		let sortedValues = values.sorted { $0.rawValue < $1.rawValue }
		for suit in sortedSuits {
			for value in sortedValues {
				cards.append(.init(suit: suit, value: value))
			}
		}
		return cards
	}

	public mutating func shuffle() {
		cards.shuffle()
	}

	public mutating func defineTrump() {
		if !cards.isEmpty {
			trump = cards.last?.suit
			setTrumpCards(for: trump!)
		}
	}

	public mutating func initialCardsDealForPlayers(players: [Player]) {
		for i in players.indices {
			players[i].hand = cards.suffix(6)
			cards.removeLast(6)
		}
	}

	public mutating func setTrumpCards(for suit:Suit) {
		for i in cards.indices {
			cards[i].isTrump = cards[i].suit == suit
		}
	}
}
