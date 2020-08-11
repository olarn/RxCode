import Foundation
import RxSwift

let bag = DisposeBag()

//let subject1 = PublishSubject<Int>()
//
//subject1.subscribe(onNext: { (value) in
//	print("#1 -> \(value)")
//}).disposed(by: bag)
//
//subject1.onNext(1)
//subject1.onNext(2)
//
//subject1.subscribe(onNext: { (value) in
//	print("#2 -> \(value)")
//}).disposed(by: bag)
//
//subject1.onNext(3)
//subject1.onNext(4)
//subject1.onNext(5)
//
//subject1.subscribe(onNext: { (value) in
//	print("#3 -> \(value)")
//}).disposed(by: bag)
//

//func returnObservable(intNumber: Int) -> Observable<String> {
//	return BehaviorSubject<Int>(value: intNumber)
//		.filter({ input -> Bool in
//			return input % 2 == 0
//		})
//		.map({ value -> String in
//			return String(value)
//		})
//}
//
//returnObservable(intNumber: 2).subscribe(onNext: { (value) in
//	print(value)
//})
//
