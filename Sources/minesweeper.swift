//  Write some awesome Swift code, or import libraries like "Foundation",
//  "Dispatch", or "Glibc"
class MineSweeper {
	
	let board = Board()
	
	init(){
		fillBoard()
	}
	
	func fillBoard(){
		
		var placedMines = 0
		let maxMines = 10
		
		let mineGenerator = MineGenerator(64)
		
		while placedMines < maxMines {

    		let mine = mineGenerator.getMine()
		    //placeMine will be false if the spot is already used
		    if board.placeMine(mine) {
 		       placedMines += 1
		    }
		}
	}
	
	func loop(){
		var col = 0
		var row = 0

		while row < 8 {
			//print the board
			print( "PRINTING BOARD")
			board.boardPrint()

			col = 0
			while col < 8 {
				//clic on the board!
				print( "CLICKED AT \(col), \(row)")
				board.click(col,row)
				col += 1
			}
			row += 1
		}
	}
}


