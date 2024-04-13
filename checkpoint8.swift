import Cocoa
//make protocol that describes building, with various properties and methods
//create two structs House and Office that conform to it

protocol Buildable {
    var rooms: Int {get}
    var cost: Int {get}
    var agent: String {get}
    func printSummary()
}

struct House: Buildable {
    var rooms: Int
    var cost: Int
    var agent: String
    func printSummary(){
        print("This House has \(rooms) rooms, and costs $\(cost). The agent selling this house is \(agent).")
    }
}

struct Office: Buildable {
    var rooms: Int
    var cost: Int
    var agent: String
    func printSummary(){
        print("This Office has \(rooms) rooms, and costs $\(cost). The agent selling this office is \(agent).")
    }
}

let h1 = House(rooms: 10, cost: 100_000_000, agent: "Lebron James")
h1.printSummary()

let c1 = Office(rooms:50, cost: 200_000_000, agent: "Bob Bobby")
c1.printSummary()
