import Foundation
import RxAlamofire
import RxSwift

struct User: Codable {
	var userName: String
	var firstName: String
	var lastName: String
}

let bag = DisposeBag()

RxAlamofire
	.data(.get, "https://extendsclass.com/api/json-storage/bin/ffddddb")
	.debug()
	.subscribe(onNext: { data in
		let decoder = JSONDecoder()
		do {
			let user = try decoder.decode(User.self, from: data)
			print(user)
		} catch {
			print("error")
		}
	})
	.disposed(by: bag)
