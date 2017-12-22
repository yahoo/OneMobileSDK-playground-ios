//  Copyright © 2017 Oath. All rights reserved.

import UIKit


class TutorialsViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        guard let tutorialCasesViewController = segue.destination as? TutorialCasesViewController else { fatalError("Unknown destination") }
        
        switch identifier {
        case "PlayingVideos": setupPlayingVideos(tutorialCasesViewController: tutorialCasesViewController)
        case "CustomUX": setupCustomUX(tutorialCasesViewController: tutorialCasesViewController)
        default: break
        }
    }
}

