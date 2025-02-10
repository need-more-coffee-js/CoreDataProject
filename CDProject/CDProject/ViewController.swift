
import UIKit

class NavC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Устанавливаем RootViewController как корневой контроллер
        let rootVC = RootViewController()
        self.viewControllers = [rootVC] // Устанавливаем массив контроллеров
    }
}
