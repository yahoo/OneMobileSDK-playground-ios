//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import CoreImage
import OneMobileSDK


class SystemPlayerViewControllerWrapper: UIViewController {
    struct Props {
        var player: Future<Result<Player>>?
        var filter: CIFilter?
    }
    
    var props = Props() {
        didSet {
            guard let player = props.player else { systemPlayerViewController?.player = nil; return }
            
            func show(error: Error) {
                let alert = UIAlertController(title: "Error",
                                              message: "\(error)",
                    preferredStyle: .alert)
                alert.addAction(.init(title: "OK",
                                      style: .default,
                                      handler: nil))
                present(alert,
                        animated: true,
                        completion: nil)
            }
            
            func render(player: Player) {
                if let filter = props.filter {
                    systemPlayerViewController?.contentCIFilterHandler = {
                        guard let outputImage = filter.outputImage else { return }
                        filter.setValue($0.sourceImage, forKey: kCIInputImageKey)
                        $0.finish(with: outputImage, context: nil)
                    }
                }
                
                systemPlayerViewController?.player = player
            }
            
            player
                .dispatch(on: .main)
                .onSuccess(call: render)
                .onError(call: show)
        }
    }
    private var systemPlayerViewController: SystemPlayerViewController? {
        return childViewControllers.first as? SystemPlayerViewController
    }
}
