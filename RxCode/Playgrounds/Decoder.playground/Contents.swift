/// ``` tutorial https://www.hackingwithswift.com/example-code/language/how-to-convert-json-into-swift-objects-using-codable

import Foundation

let jsonString = """
[
    {
        "name": "Taylor Swift",
        "age": 26
    },
    {
        "name": "Justin Bieber",
        "age": 25
    }
]
"""

let jsonData = Data(jsonString.utf8)

struct Person: Codable {
    var name: String
    var age: Int
}

let decoder = JSONDecoder()

do {
    let people = try decoder.decode([Person].self, from: jsonData)
    print(people)
} catch {
    print(error.localizedDescription)
}
