import PlaygroundSupport
import RxSwift
import RxCocoa

let names = BehaviorRelay<[String]>(value: [])

names.asObservable()
    .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
    .filter { value in
        return value.count > 1
    }
//    .debug()
    .map { value in
        return "users: \(value)"
    }
//    .debug()
    .subscribe(onNext: { value in
        print(value)
    })

names.accept(["Peter"])
names.accept(["Peter", "John"])

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    names.accept(["Claudia", "Alice"])
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    names.accept(["Admin"])
}
