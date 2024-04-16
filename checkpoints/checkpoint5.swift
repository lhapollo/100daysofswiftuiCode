import Cocoa
//filter out even, sort in ascending, map to "x is a lucky number", print

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
var b = luckyNumbers.sorted()
b = b.filter{$0 % 2 == 1}
var c = b.map{String($0)}
for x in c{
    print(x + " is a lucky number.")
}
