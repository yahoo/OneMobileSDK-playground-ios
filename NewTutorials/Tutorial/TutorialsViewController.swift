//  Copyright © 2017 Oath. All rights reserved.

import UIKit

class TutorialsViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch (identifier, segue.destination) {
        case ("PlayingVideos", let vc as TutorialCasesViewController): setupPlayingVideos(vc: vc)
        default: break
        }
    }
}

