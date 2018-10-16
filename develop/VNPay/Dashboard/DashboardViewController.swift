import UIKit

protocol DashboardDelegate: class {
    func didLogOut()
}
class DashboardViewController: UIViewController {
    weak var delegate: DashboardDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        dashboardView.layoutButtons(withTarget: self)
    }
    
    func runShowAnimation(_ complete: @escaping () -> ()) {
        dashboardView.runShowAnimation(complete)
    }

    func runHideAnimation(_ complete: @escaping () -> ()) {
        dashboardView.runHideAnimation(complete)
    }
    
    @objc
    func buttonPressed() {
        delegate?.didLogOut()
    }
    
    var dashboardView: DashboardView {
        return view as! DashboardView
    }

}
