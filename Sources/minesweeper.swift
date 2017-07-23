//  Write some awesome Swift code, or import libraries like "Foundation",
//  "Dispatch", or "Glibc"
import Foundation

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
		board.boardPrint()
		board.click(0,0)
		print("CLICK")
		board.boardPrint()
		board.click(0,1)
		print("CLICK")
		board.boardPrint()
		board.click(1,0)
		print("CLICK")
		board.boardPrint()
		board.click(1,1)
		print("CLICK")
		board.boardPrint()
	}
}

class Board {
	var data:[Int]
	
	let MineCell = 9
	let MineCellPressed = -1
	let ROWS = 8
	let COLS = 8 
	
	init(){
		data = [Int](repeating: 10, count: 64)
	}
	
	func placeMine(_ mine:Int) -> Bool{
        
        var minePlaced = false 
        
        if data[mine] != MineCell {
            data[mine] = MineCell  
            fillNeighbors(mine)
            minePlaced = true 
        }
        
        return minePlaced
    }
	
	func fillNeighbors(_ mine:Int) {
     
        let col = mine % COLS;
        let row = mine / COLS;
		
        updateNeighbor(col-1, row-1)
        updateNeighbor(col, row-1)
        updateNeighbor(col+1,row-1)
        
        updateNeighbor(col-1, row)
        updateNeighbor(col+1, row)
        
        updateNeighbor(col-1, row+1)
        updateNeighbor(col, row+1)
        updateNeighbor(col+1,row+1)
    }
	
	func updateNeighbor(_ col:Int,_ row:Int){
        if valid( col, row ) && 
		data [(row * COLS) +  col] != MineCell {
            data [(row * COLS) +  col] += 1
        }
    }
    
    	func valid(_ col:Int, _ row:Int)->Bool{
        	return col>=0 && col<COLS && row>=0 && row<ROWS 
    	}
	
	func click(_ col:Int,_ row:Int){
       		let element = getElementAt(col, row)
    
       		if( element >= MineCell ){
           		setElement(element-10, col, row)
       		}
    	}
	
	func boardPrint(){
		
		var newline = 0
		
		for element in data {
			
			if element >= MineCell{
                print (" O ", terminator:"")
            }else{
				if(element == MineCellPressed){
					print (" X ", terminator:"")
				}else{
					print (" \(element) ", terminator:"")	
				}
            }
			
			newline += 1
			if newline == 8 {
				print("\n")
				newline = 0
			}
		}
	}
	
	func getElementAt(_ col:Int , _ row:Int) -> Int{
        
        return data [(row * COLS) +  col];
    }
    
    func setElement(_ value:Int, _ col:Int , _ row:Int){
        if( valid(col, row)){
            data [(row * COLS) +  col] = value;
        }
        
    }
}

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
