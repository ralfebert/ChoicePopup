import UIKit

enum Direction : String {
    
    case north, east, south, west
    
    static var allValues = [Direction.north, .east, .south, .west]
    
}

struct ExampleModel {
    var direction = Direction.north
}


class ExampleViewController : UIViewController {
    
    var model = ExampleModel() {
        didSet {
            self.view.setNeedsLayout()
        }
    }

    @IBOutlet weak var button: UIButton!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.button.setTitle(String(describing: model.direction), for: .normal)
    }

    @IBAction func showDirectionPopup(_ sender: UIView) {
        let controller = ArrayChoiceTableViewController(Direction.allValues) { (direction) in
            self.model.direction = direction
        }
        controller.preferredContentSize = CGSize(width: 300, height: 200)
        showPopup(controller, sourceView: sender)
    }
    
    private func showPopup(_ controller: UIViewController, sourceView: UIView) {
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        presentationController.sourceView = sourceView
        presentationController.sourceRect = sourceView.bounds
        presentationController.permittedArrowDirections = [.down, .up]
        self.present(controller, animated: true)
    }

}
