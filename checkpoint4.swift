import Cocoa
//write a function that accepts an integer from 1-10000
//returns square root of number (only return integer square roots)
//throws error if you can't find square root OR if number out of range

enum FuncError: Error{
    case outOfBounds, noRoot
}

func integerSquareRoot(x: Int) throws -> Int{
    if (x < 1 || x > 10000){
        throw FuncError.outOfBounds
    }
    for i in 1...100 {
        if (i*i == x){
            return i;
        }
    }
    
    throw FuncError.noRoot
}
 
do {
    let t1 = try integerSquareRoot(x: 25)
    //let t2 = try integerSquareRoot(x: 30)
    //let t3 = try integerSquareRoot(x: 0)
}
catch FuncError.outOfBounds{
    print("out of bounds")
}
catch FuncError.noRoot{
    print("no root")
}


