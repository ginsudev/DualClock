import SwiftUI
import Comet
import dualclock2C

class RootListController: CMViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup(content: RootView())
        self.title = nil
        self.navigationItem.largeTitleDisplayMode = .never
    }
}
