import UIKit
import RxSwift

example(of: "start with operator") {
    let disposeBag = DisposeBag()
    
    let prequelEpisode = Observable.of(episodeI,episodeII,episodeIII)
    let flashbag = prequelEpisode.startWith(episodeIV,episodeV)
    
    flashbag
        .subscribe(onNext: { episode in
                   print(episode)
        })
        .disposed(by: disposeBag)
}

example(of: "concat operator") {
    let disposeBag = DisposeBag()

    let prequelTrylogy = Observable.of(episodeI,episodeII,episodeIII)
    let originalTrylogy = Observable.of(episodeIV,episodeV,episodeVI)
    
    prequelTrylogy.concat(originalTrylogy)
        .subscribe(onNext: { episode in
            print(episode)
        })
        .disposed(by: disposeBag)
}

example(of: "merge operator") {
    let disposeBag = DisposeBag()

    let filmTrylogy = PublishSubject<String>()
    let standaloneFilms = PublishSubject<String>()
    let storyOrder = Observable.of(filmTrylogy,standaloneFilms)
    
    storyOrder.merge()
        .subscribe(onNext: { episode in
            print(episode)
        })
        .disposed(by: disposeBag)
    
    filmTrylogy.onNext(episodeI)
    filmTrylogy.onNext(episodeII)
    
    standaloneFilms.onNext(theCloneWars)
    
    filmTrylogy.onNext(episodeIII)
    
    standaloneFilms.onNext(solo)
    standaloneFilms.onNext(rogueOne)
    
    filmTrylogy.onNext(episodeIV)
}

example(of: "Cobine Latest operator") {
    let disposeBag = DisposeBag()
    
    let characters = Observable.of(luke, hanSolo, leia, chewbacca)
    let primaryWeapons = Observable.of(lightsaber, dl44, defender, bowcaster)
    
    Observable.combineLatest(characters, primaryWeapons) { character, weapons in
        "\(character): \(weapons)"
    }.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}

example(of: "zip operator") {
    let disposeBag = DisposeBag()
    
    let characters = Observable.of(luke, hanSolo, leia, chewbacca)
    let primaryWeapons = Observable.of(lightsaber, dl44, defender, bowcaster)
    
    Observable.zip(characters, primaryWeapons) { character, weapons in
        "\(character): \(weapons)"
    }.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}

example(of: "amb operator") {
    let disposeBag = DisposeBag()
    
    let prequelEpisodes = PublishSubject<String>()
    let originalEpisodes = PublishSubject<String>()
    
    prequelEpisodes.amb(originalEpisodes)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    originalEpisodes.onNext(episodeIV)

    prequelEpisodes.onNext(episodeI)
    prequelEpisodes.onNext(episodeII)
    
    originalEpisodes.onNext(episodeV)
}
example(of: "reduce") {
    let disposeBag = DisposeBag()
    
    Observable.from(runtimes.values)
        .reduce(0, accumulator: +)
        .subscribe(onNext: {
            print(stringFrom($0))
        })
        .disposed(by: disposeBag)
}
