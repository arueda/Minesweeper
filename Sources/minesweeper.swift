//  Write some awesome Swift code, or import libraries like "Foundation",
//  "Dispatch", or "Glibc"
class MineSweeper : BoardListener{
	
	var endGame = false
	
	func loop(){
		let board:Board = Board(boardListener:self)
		board.fillBoard(rows:8, cols:8)
		board.boardPrint()

		var col = 0
		var row = 0

		while row < 8 && !endGame{
			col = 0
			while col < 8  && !endGame{
				//click on the board!
				print( "CLICK AT \(col), \(row)")
				board.click(col,row)
				board.boardPrint()
				col += 1
			}
			row += 1
		}
	}

	func minePressed() -> Void{
		endGame = true
		print("perdiste")
	}
    func gameEnded() -> Void{
		endGame = true
	}
}


