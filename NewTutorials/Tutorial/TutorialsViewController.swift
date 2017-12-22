//  Copyright © 2017 Oath. All rights reserved.

import UIKit


class TutorialsViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        guard let vc = segue.destination as? TutorialCasesViewController else { fatalError("Unknown destination") }
        
        switch (identifier) {
        case ("PlayingVideos"): setupPlayingVideos(vc: vc)
        case ("CustomUX"): setupCustomUX(vc: vc)
        default: break
        }
    }
}

