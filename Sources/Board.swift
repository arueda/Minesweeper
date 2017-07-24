class Board {
	var data:[Int]
	
	let MineCell = 9
    let EmptyCell = 10
    let MineCellPressed = -1
    let EmptyCellPressed = 0

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
    
        if element == MineCell {
            print ("GAME OVER")
        }else if  element >= MineCell {
       		expansion(col, row)
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

	func expansion(_ col:Int, _ row:Int){

        var q : [Int] = []
        
        q.append((row * COLS) +  col)
        
        while !q.isEmpty {
        
            let mine = q.removeFirst()
            
            let col = mine % COLS;
            let row = mine / COLS;
            
            if data[mine] == EmptyCell  {
            
                data[mine] = EmptyCellPressed

                let rowMinus1 = row-1
                let rowPlus1 = row+1
                let colMinus1 = col - 1
                let colPlus1 = col + 1
                
                if valid(col-1, row-1) {q.append((rowMinus1 * COLS) +  colMinus1)}
                if valid(col,   row-1) {q.append((rowMinus1 * COLS) +  col)}
                if valid(col+1, row-1) {q.append((rowMinus1 * COLS) +  colPlus1)}
        
                if valid(col-1, row) {q.append((row * COLS) +  colMinus1)}
                if valid(col+1, row) {q.append((row * COLS) +  colPlus1)}
        
                if valid(col-1, row+1) {q.append((rowPlus1 * COLS) +  colMinus1)}
                if valid(col,   row+1) {q.append((rowPlus1 * COLS) +  col)}
                if valid(col+1, row+1) {q.append((rowPlus1 * COLS) +  colPlus1)}
                
            }else if data[mine] > EmptyCell {
                data[mine] -= 10
            }
        }
    }
}