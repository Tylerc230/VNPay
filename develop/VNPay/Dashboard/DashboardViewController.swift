import Choreo
import Disco
class DashboardViewController: UIViewController {
    @IBOutlet var columns: UIStackView!
    func layoutButtons() {
        let buttons = [[("My Profile"), ("Transaction Report"), ("Other")],
            [("Fund Transfer"), ("Register"), ("Search")],
            [("Payment"), ("Top Up"), ("Settings")]]
        buttons.enumerated().forEach { args in
            let (columnNum, columnValues) = args
            guard let columnStackView = columns.arrangedSubviews[columnNum] as? UIStackView else {
                return
            }
            columnValues.forEach { buttonName in
                let button = DashboardActionButton.button()
                button.set(text: buttonName, icon: "")
                columnStackView.addArrangedSubview(button)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutButtons()
    }
    
    func runShowAnimation(_ complete: @escaping () -> ()) {
        guard let stackViews = self.columns.arrangedSubviews as? [UIStackView] else {
            return
        }
        Choreo()
            .prepareAnimations {
                stackViews
                    .flatMap { $0.arrangedSubviews }
                    .forEach { button in
                        button.layer.transform = CATransform3DMakeScale(0.0, 0.0, 1.0)
                    }
                
            }
            .addStaggeredAnimation(views: columns.arrangedSubviews, startFraction: 0.0, durationFraction: 1.0, delayFraction: 0.05) { (view, duration) in
                guard let stackView = view as? UIStackView else {
                    return
                }
                let columnButtons = stackView.arrangedSubviews
                columnButtons.forEach { button in
                    _ = button.disco
                        .duration(duration)
                        .setTiming(.springBased(0.75))
                        .setTransform(to: .identity)
                        .start()
                }
            }
            .onComplete(complete)
            .animate(totalDuration: 0.6)
    }
    
}
