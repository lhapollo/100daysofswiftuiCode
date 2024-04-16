import Cocoa
//class hiearchy
//Animal class -> Dog & Cat subclass of Animal -> Corgi & Poodle subclass of Dog, Persian and Lion subclass of Cat
//Animal has legs int property
//Dog has speak() method subclasses slightly different speak()
//Cat has speak() method subclasses slightly different
//Cat has isTame boolean property

class Animal {
    let legs: Int
    init(animalLegs legs: Int){
        self.legs = legs
    }
}

class Dog: Animal{
    init(dogLegs legs: Int){
        super.init(animalLegs: legs)
    }
    func speak(){
        print("Woof Woof! Dog!")
    }
}

class Cat: Animal {
    init(catLegs legs: Int){
        super.init(animalLegs: legs)
    }
    func speak(){
        print("Meow Meow! Cat!")
    }
}

class Corgi: Dog {
    init(corgiLegs legs: Int){
        super.init(dogLegs: legs)
    }
    override func speak(){
        print("Woof! Corgi!")
    }
}

class Poodle: Dog {
    init(poodleLegs legs: Int){
        super.init(dogLegs: legs)
    }
    override func speak(){
        print("Woof! Poodle!")
    }
}

class Persian: Cat {
    init(persianLegs legs: Int){
        super.init(catLegs: legs)
    }
    override func speak(){
        print("Meow! Persian!")
    }
}

class Lion: Cat {
    init(lionLegs legs: Int){
        super.init(catLegs: legs)
    }
    override func speak(){
        print("Meow! Lion!")
    }
}

var a1 = Animal(animalLegs: 5)
print(a1.legs)

var d1 = Dog(dogLegs: 4)
d1.speak()

var c1 = Cat(catLegs: 4)
c1.speak()

var d2 = Corgi(corgiLegs: 4)
d2.speak()

var d3 = Poodle(poodleLegs: 4)
d3.speak()

var c2 = Persian(persianLegs: 4)
c2.speak()

var c3 = Lion(lionLegs: 4)
c3.speak()
