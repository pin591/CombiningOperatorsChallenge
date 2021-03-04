import UIKit
import RxSwift

example(of: "zip + scan") {
  
  let disposeBag = DisposeBag()
  
  let runtimeKeyValues = Observable.from(runtimes)
  
  let scanTotals = runtimeKeyValues.scan(0) { runningTotal, movie in
    runningTotal + movie.value
  }
  
  let results = Observable.zip(runtimeKeyValues, scanTotals) {
    ($0.key, $0.value, $1)
  }
  
  results
    .subscribe(onNext: {
      print("\($0):", stringFrom($1), "(\(stringFrom($2)))")
    })
    .disposed(by: disposeBag)
}

