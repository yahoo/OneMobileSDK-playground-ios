//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import UIKit

class TutorialsViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch (identifier, segue.destination) {
        case ("PlayingVideosViewController", let vc as PlayingVideosViewController): setup(playingVideoViewController: vc)
        default: break
        }
    }
}

