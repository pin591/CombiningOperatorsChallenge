import UIKit
import RxSwift


public let episodeI = "1-The Phantom Menace"
public let episodeII = "2-Attack of the Clones"
public let theCloneWars = "The Clone Wars"
public let episodeIII = "3-Revenge if the sith"
public let solo = "Solo"
public let rogueOne = "Rogue One"
public let episodeIV = "4-A new Hope"
public let episodeV = "5-The Empire Strikes Back"
public let episodeVI = "6-Return Of the Jedi"
public let episodeVII = "7-The Force Awakens"
public let episodeVIII = "8-The Last Jedi"
public let episodeIX = "9-Episode IX"

public func example(of description: String, action: () -> Void) {
    print ("\n---- Example of:", description, "-----")
    action()
}

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
    
    let characters = Observable.of("luke", "hashSolo", "leia", "chewbacca")
    let primaryWeapons = Observable.of("lightaber", "dl44", "defender", "bowcaster")
    
    Observable.combineLatest(characters, primaryWeapons) { character, weapons in
        "\(character): \(weapons)"
    }.subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
}

example(of: "zip operator") {
    let disposeBag = DisposeBag()
    
    let characters = Observable.of("luke", "hashSolo", "leia", "chewbacca")
    let primaryWeapons = Observable.of("lightaber", "dl44", "defender", "bowcaster")
    
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
