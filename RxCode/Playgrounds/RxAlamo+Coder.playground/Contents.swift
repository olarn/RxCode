import UIKit
import Alamofire
import RxSwift
import RxAlamofire

struct Account: Codable {
	var idType: String
	var idValue: String
}

enum ApiResult<Value> {
	case success(Value)
	case fail(Error)
}

let bag = DisposeBag()

func clientRequest<TypeOfBody: Encodable>(
	urlString: String,
	method: String = "GET",
	bodyObject: TypeOfBody) {
	var request = URLRequest(url: URL(string: urlString)!)
	request.httpMethod = method
	request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	do {
		request.httpBody = try JSONEncoder().encode(bodyObject)
	} catch {
		print("Convert Error")
	}

	RxAlamofire
		.request(request as URLRequestConvertible)
		.responseData()
		.subscribe(onNext: { (_, data) in
			print(data)
		}).disposed(by: bag)
}

let urlString = "https://api.c1-alpha-tiscogroup.com/public/wmb-port-v1-service/wmb-port/accounts/inquiry"
let accountRequest = Account(
	idType: "I",
	idValue: "3100202497392"
)
