import Foundation

struct SeatRange {
	let length: Int
	var begin = 0
	var end = 0
	
	var distance: Int {
		if end == begin {
			return 0
		}
		var dist = end - begin + 1
		// is not edge - distance is devided
		if begin != 0 && end != length {
			dist /= 2
		}
		return dist
	}
	
	var optimalPosition: Int {
		if begin == 0 {
			return 0
		}
		if end == length {
			return length - 1
		}
		return begin + distance - 1
	}
}

class CoronaClass {
	var seats = [Int]()
	let seatsLeftEdge: Int = -1
	let seatsRightEdge: Int

	init(n: Int) {
		seatsRightEdge = n
	}

	func seat() -> Int {
		if seatsRightEdge < 1 || 100 < seatsRightEdge {
			return -1
		}
		if seats.count >= seatsRightEdge {
			return -1
		}
		if seats.isEmpty {
			let position = 0
			seats.append(0)
			return position
		}
		
		let seatsWithEdges = [seatsLeftEdge] + seats + [seatsRightEdge]
		var bestFreeRange: SeatRange?
		for i in 1 ..< seatsWithEdges.count {
			var freeRange = SeatRange(length: seatsRightEdge)
			freeRange.begin = seatsWithEdges[i-1] + 1
			freeRange.end   = seatsWithEdges[i]
			if bestFreeRange?.distance ?? 0 < freeRange.distance {
				bestFreeRange = freeRange
			}
		}
		guard let freeRange = bestFreeRange else {
			return -1
		}
		
		let position = freeRange.optimalPosition
		seats.append(position)
		seats.sort()
		return position
	}
	
	func leave(_ p: Int) {
		guard let index = seats.firstIndex(of: p) else {return}
		seats.remove(at: index)
	}
}
