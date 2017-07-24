import Foundation

class MineGenerator {
	
	let MAX:Int
	
	init(_ value:Int){
		MAX = value
		srandom(UInt32(time(nil))) 
	}
	func getMine() -> Int {
		return Int(arc4random_uniform(UInt32(MAX)))
	}
}