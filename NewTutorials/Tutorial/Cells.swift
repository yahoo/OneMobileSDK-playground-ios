//  Copyright © 2017 Oath. All rights reserved.

import UIKit


class TextCell: UITableViewCell {
    struct ViewModel {
        let name: String
        let action: (PlayerViewControllerWrapper) -> ()
    }
    
    @IBOutlet weak private var nameLabel: UILabel!
    
    var viewModel = ViewModel(name: "", action: { _ in }) {
        didSet { layoutSubviews() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.text = viewModel.name
    }
}
