//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let playersCollectionViewController = segue.destination as? PlayersCollectionViewController else { return }
        
        let data = PlayersCollectionDTO(playersData:
            [PlayersCollectionDTO.PlayerCellDTO(videoId: "593967be9e45105fa1b5939a"),
             PlayersCollectionDTO.PlayerCellDTO(videoId: "577cc23d50954952cc56bc47"),
             PlayersCollectionDTO.PlayerCellDTO(videoId: "59397934955a316f1c4f65b4"),
             PlayersCollectionDTO.PlayerCellDTO(videoId: "5939698f85eb427b86aa0a14")])
        
        playersCollectionViewController.dataSource = data
    }
}

