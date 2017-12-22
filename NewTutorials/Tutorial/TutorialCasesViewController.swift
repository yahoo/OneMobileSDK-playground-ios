//  Copyright © 2017 Oath. All rights reserved.

import UIKit


class TutorialCasesViewController: UITableViewController {
    struct Props {
        var rows: [TextCell.ViewModel] = []
    }
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    var props: Props = Props() {
        didSet {
            guard isViewLoaded else { return }
            tableView.reloadData()
        }
    }
    
    func show(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") as? TextCell else {
            fatalError("Unknown cell")
        }
        cell.viewModel = props.rows[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        props.rows[indexPath.row].action()
    }
}
