import Cocoa
//one line: write a function that accepts an [Int]? and returns one randomly, if array is missing or empty, return random number in the range 1 thru 100

func fun(param: [Int]?) -> Int? {param?.randomElement() ?? Int.random(in: 1...100)}

let v1 = fun(param: [1, 2, 3, 4])
let v2 = fun(param: nil)

print(v1)
print(v2)
