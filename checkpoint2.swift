//creates array of strings
//prints number of items in array
//prints number of unique items in array

import Cocoa

let array: [String] = ["Drake", "The Weeknd", "Kanye West", "The Weeknd"]
print(array.count)
let set = Set(array)
print(set.count)
