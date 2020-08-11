import Foundation

enum ShapeType {
    case circle
    case square
}

protocol Shape {
    associatedtype ShapeColor
    var color: ShapeColor { get }
    func describe() -> String
}

struct Square: Shape {
    var color: String
    func describe() -> String {
        return "I'm Square with \(color) color."
    }
}

struct Circle: Shape {
    var color: Int
    func describe() -> String {
        return "I'm Circle with \(color) color code."
    }
}

// error Protocol 'Shape' can only be used as a generic constraint because it has Self or associated type requirements
// if not specific 'some' keyword
func getSquare() -> some Shape {
    return Square(color: "red")
}

func getCircle() -> some Shape {
    return Circle(color: 127)
}

let squ = getSquare()
print(squ.describe())

let cir = getCircle()
print(cir.describe())
