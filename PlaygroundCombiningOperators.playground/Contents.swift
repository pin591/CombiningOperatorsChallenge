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
