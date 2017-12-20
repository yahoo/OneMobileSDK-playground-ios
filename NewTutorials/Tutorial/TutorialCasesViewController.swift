//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK


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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as? TextCell else {
            fatalError("Unknown cell")
        }
        cell.viewModel = props.rows[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        props.rows[indexPath.row].action()
    }
}

class PlayerViewControllerWrapper: UIViewController {
    struct Props {
        var isLoading = false
    }
    
    var props = Props() {
        didSet {
            view.setNeedsLayout()
        }
    }
    let playerViewController = PlayerViewController()
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.isHidden = true
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerViewController.willMove(toParentViewController: self)
        addChildViewController(playerViewController)
        view.addSubview(playerViewController.view)
        playerViewController.didMove(toParentViewController: self)
        activityIndicatorView.color = view.tintColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicatorView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        activityIndicatorView.isHidden = !props.isLoading
        props.isLoading ?
            activityIndicatorView.startAnimating() :
            activityIndicatorView.stopAnimating()
    }
}
