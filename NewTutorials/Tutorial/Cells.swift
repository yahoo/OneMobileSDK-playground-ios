//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import UIKit


protocol CellViewModel {}

class TextCell: UITableViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    
    struct ViewModel: CellViewModel {
        let name: String
        let action: () -> ()
    }
    
    var viewModel: ViewModel! {
        didSet { layoutSubviews() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.nameLabel.text = viewModel.name
    }
}

class SwitchCell: UITableViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    
    struct ViewModel: CellViewModel {
        let name: String
        let action: () -> ()
    }
    
    var viewModel: ViewModel! {
        didSet { layoutSubviews() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.nameLabel.text = viewModel.name
    }
    
    @IBAction func switchToggled() {
        viewModel.action()
    }
}
