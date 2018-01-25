import UIKit

@objc enum Direction : Int, CustomStringConvertible {
    
    case north, east, south, west
    
    static var allValues = [Direction.north, .east, .south, .west]
    
    var description: String {
        switch self {
        case .north: return "north"
        case .east: return "east"
        case .south: return "south"
        case .west: return "west"
        }
    }

}

class ExampleModel : NSObject {
    @objc dynamic var direction = Direction.north
}


class ExampleViewController : UIViewController {
    
    var model = ExampleModel()
    var observers : [NSKeyValueObservation] = []

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.observers = bindModel()
    }
    
    private func bindModel() -> [NSKeyValueObservation] {
        return [
            self.model.observe(\.direction, options: .initial) { (model, _) in
                self.button.setTitle(String(describing: model.direction), for: .normal)
            }
        ]
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
