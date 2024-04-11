import Cocoa
//create struct about CAR

struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var gear = 1
    
    mutating func changeGear(To gearNum: Int) -> Bool{
        if gearNum >= 1 && gearNum <= 10{
            gear = gearNum
            return true;
        } else {
            return false
        }
    }
}

var car1 = Car(model: "Tesla X", numberOfSeats: 5)
print(car1.model)
car1.changeGear(To: 5)
print(car1.gear)
