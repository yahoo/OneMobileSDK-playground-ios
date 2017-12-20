//  Copyright © 2017 Oath. All rights reserved.

import UIKit


class TextCell: UITableViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    
    struct ViewModel {
        let name: String
        let action: () -> ()
    }
    
    var viewModel = ViewModel(name: "", action: {}) {
        didSet { layoutSubviews() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.text = viewModel.name
    }
}
