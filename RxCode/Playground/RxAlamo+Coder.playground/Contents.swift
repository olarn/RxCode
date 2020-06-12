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
	bodyObject: TypeOfBody) // -> Observable<(HTTPURLResponse, Data)>
{
	var request = URLRequest(url: URL(string: urlString)!)
	request.httpMethod = method
	request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	request.httpBody = try! JSONEncoder().encode(bodyObject)
	
	//	return RxAlamofire
	//		.request(request as URLRequestConvertible)
	//		.responseData()
	
	RxAlamofire
		.request(request as URLRequestConvertible)
		.responseData()
		.subscribe(onNext: { (res, data) in
			print(data)
		}).disposed(by: bag)
}

let urlString = "https://api.c1-alpha-tiscogroup.com/public/wmb-port-v1-service/wmb-port/accounts/inquiry"
let accountRequest = Account(
	idType: "I",
	idValue: "3100202497392"
)

clientRequest(urlString: urlString, method: "POST", bodyObject: accountRequest)
//	.subscribe(onNext: { (response, data) in
//		print(data)
//	}, onError: { (error) in
//		print("Error -> \(error.localizedDescription)")
//	}, onCompleted: {
//		print("Completed")
//	})


