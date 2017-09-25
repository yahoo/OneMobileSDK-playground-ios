//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit
import OneMobileSDK
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var ciFilterSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func handle(result: Result<One.Player>) {
        var prevContentIsFinished: Bool?
        
        switch result {
        case .value(let player):
            _ = player.addObserver(
                on: DispatchQueue.global(qos: .background),
                mode: .everyUpdate,
                { (props) in
                    guard let isFinished = props.playbackItem?.content.isFinished, isFinished != prevContentIsFinished else { return }
                    prevContentIsFinished = isFinished
                    self.print(event: "Content isFinished state did change: \(isFinished)")
                }
            )
            
            let systemPlayerViewController = SystemPlayerViewController()
            
            /* attaching metadata to player view */ do {
                let titleMetadataItem = AVMutableMetadataItem()
                titleMetadataItem.locale = NSLocale.current
                titleMetadataItem.key = NSString(string: AVMetadataCommonKeyTitle)
                titleMetadataItem.keySpace = AVMetadataKeySpaceCommon
                titleMetadataItem.value = NSString(string: "The Title")
                
                systemPlayerViewController.contentVideoMetadata = [titleMetadataItem]
            }
            
            if ciFilterSegmentedControl.selectedSegmentIndex == 0 {
                
                /* attaching CIFilter to the content video */ do {
                    let filter = CIFilter(name: "CIPhotoEffectNoir")!
                    systemPlayerViewController.contentCIFilterHandler = { request in
                        filter.setValue(request.sourceImage, forKey: kCIInputImageKey)
                        
                        request.finish(with: filter.outputImage!, context: nil)
                    }
                }
            }
            
            systemPlayerViewController.player = player
            self.present(systemPlayerViewController, animated: true, completion: nil)
            
        case .error(let error):
            let alert = UIAlertController(title: "Error",
                                          message: "\(error)",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func print(event: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss,mmm"
        Swift.print("\(self): \(formatter.string(from: Date())) \(event)")
    }
    
    @IBAction func playVideoTouched(_ sender: UIButton) {
        OneSDK.Provider.default.getSDK()
            .then { $0.getPlayer(videoID:"577cc23d50954952cc56bc47") }
            .dispatch(on: .main)
            .onComplete(callback: handle)
    }
    
    @IBAction func playLiveVideoTouched(_ sender: UIButton) {
        OneSDK.Provider.default.getSDK()
            .then { $0.getPlayer(videoID:"59833447b90afb42310c19da") }
            .dispatch(on: .main)
            .onComplete(callback: handle)
    }
}
