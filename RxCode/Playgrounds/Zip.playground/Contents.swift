import Foundation
import RxSwift

let bag = DisposeBag()

let first = PublishSubject<String>()
let second = PublishSubject<String>()
let third = PublishSubject<String>()

Observable.zip(first, second, third)
    .subscribe(onNext: { v1, v2, v3 in
        print("\(v1), \(v2), \(v3)\n")
    })
    .disposed(by: bag)

second.onNext("#2 -> 1")
first.onNext("#1 -> 1")

second.onNext("#2 -> 2")
third.onNext("#3 -> 1")

first.onNext("#1 -> 2")
second.onNext("#2 -> 3")
third.onNext("#3 -> 2")
