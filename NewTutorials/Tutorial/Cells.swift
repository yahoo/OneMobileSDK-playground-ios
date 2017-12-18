//  Copyright © 2017 Oath. All rights reserved.

import UIKit


protocol CellViewModel {}

class TextCell: UITableViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    
    struct ViewModel: CellViewModel {
        let name: String
        let action: () -> ()
    }
    
    var viewModel = ViewModel(name: "", action: {}) {
        didSet { layoutSubviews() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.nameLabel.text = viewModel.name
    }
}
