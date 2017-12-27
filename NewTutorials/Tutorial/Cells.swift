//  Copyright © 2017 Oath. All rights reserved.

import UIKit


class TextCell: UITableViewCell {
    struct Props {
        let name: String
        let select: (UIViewController) -> ()
    }
    
    @IBOutlet weak private var nameLabel: UILabel!
    
    var props = Props(name: "", select: { _ in }) {
        didSet { layoutSubviews() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.text = props.name
    }
}
