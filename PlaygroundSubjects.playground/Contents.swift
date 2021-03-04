import UIKit
import RxSwift



enum Quote: Error {
  case neverSaidThat
}

let itsNotMyFault = "It’s not my fault."
let doOrDoNot = "Do. Or do not. There is no try."
let lackOfFaith = "I find your lack of faith disturbing."
let eyesCanDeceive = "Your eyes can deceive you. Don’t trust them."
let stayOnTarget = "Stay on target."
let iAmYourFather = "Luke, I am your father"
let useTheForce = "Use the Force, Luke."
let theForceIsStrong = "The Force is strong with this one."
let mayTheForceBeWithYou = "May the Force be with you."
let mayThe4thBeWithYou = "May the 4th be with you."

func example(of description: String, action: () -> Void) {
    print ("\n---- Example of:", description, "-----")
    action()
}


func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event )
}

example(of: "PublishSubjects") {

    let quotes = PublishSubject<String>()
    quotes.onNext(itsNotMyFault)

    let subscribeOne = quotes.subscribe() {
        print(label: "1)", event: $0)
    }
    
    quotes.onNext(doOrDoNot)
    
    let subscribeTwo = quotes.subscribe() {
        print(label: "2)", event: $0)
    }
    
    quotes.onNext(lackOfFaith)
    
    subscribeOne.dispose()
    
    quotes.onNext(eyesCanDeceive)
    
    quotes.onCompleted()
    
    let subscribeThree = quotes.subscribe() {
        print(label: "3)", event: $0)
    }
    
    quotes.onNext(stayOnTarget)
    
    subscribeTwo.dispose()
    subscribeThree.dispose
}

example(of: "BehaviorSubject") {
    let disposeBag = DisposeBag()
    
    let quotes = BehaviorSubject(value: iAmYourFather)
    
    let subscriptionOne = quotes.subscribe() {
        print(label: "1)", event: $0)
    }
    
    quotes.onError(Quote.neverSaidThat)

    let subscriptionTwo = quotes.subscribe() {
        print(label: "2)", event: $0)
    }
    
    subscriptionOne.disposed(by: disposeBag)
    subscriptionTwo.disposed(by: disposeBag)
}


example(of: "ReplaySubject") {
    let disposeBag = DisposeBag()
    
    let subject = ReplaySubject<String>.create(bufferSize: 6)
    
    subject.onNext(useTheForce)
    
    subject.subscribe() {
        print(label: "1)", event: $0)
    }.disposed(by: disposeBag)
    
    subject.onNext(theForceIsStrong)
    subject.onNext(mayTheForceBeWithYou)
    subject.onNext(mayThe4thBeWithYou)


    let subscriptionTwo = subject.subscribe() {
        print(label: "2)", event: $0)
    }.disposed(by: disposeBag)
}

example(of: "Variable")  {
    let disposeBag = DisposeBag()
    
    let variable = Variable(mayTheForceBeWithYou)
    
    print(variable.value)
    
    variable.asObservable()
    .subscribe() {
        print(label: "1)", event: $0)
    }.disposed(by: disposeBag)
    
    variable.value = mayThe4thBeWithYou
    print(variable.value)
    
}
