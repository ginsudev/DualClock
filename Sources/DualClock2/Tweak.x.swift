import Orion
import GSCore
import DualClock2C

struct LockScreen: HookGroup {}
struct StatusBar: HookGroup {}

class SBFLockScreenDateViewController_Hook: ClassHook<SBFLockScreenDateViewController> {
    typealias Group = LockScreen

    @Property (.nonatomic, .retain) var dualClockController = DCBaseViewController()
    
    func viewDidLoad() {
        orig.viewDidLoad()
        
        // Init DualClock base controller
        dualClockController.view.translatesAutoresizingMaskIntoConstraints = false
        target.addChild(dualClockController)
        target.view.addSubview(dualClockController.view)
        
        // Activate these constraints once.
        NSLayoutConstraint.activate([
            dualClockController.view.leadingAnchor.constraint(equalTo: target.view.leadingAnchor),
            dualClockController.view.trailingAnchor.constraint(equalTo: target.view.trailingAnchor),
            dualClockController.view.topAnchor.constraint(equalTo: target.view.topAnchor)
        ])
    }
}

class SBFLockScreenDateView: ClassHook<UIView> {
    typealias Group = LockScreen

    static var targetName: String = "SBFLockScreenDateView"
    
    func didAddSubview(_ subview: UIView) {
        orig.didAddSubview(subview)
        
        if (subview == Ivars<UIView>(target)._timeLabel || (subview == Ivars<UIView>(target)._dateSubtitleView && !PreferenceManager.shared.settings.lockScreen.isSingleDate)) {
            subview.removeFromSuperview()
        }
    }
    
    func layoutSubviews() {
        orig.layoutSubviews()
        guard !GlobalState.shared.isLandscapeExcludingiPad else {
            return
        }
        
        var bounds = target.bounds
        bounds.origin.y = PreferenceManager.shared.settings.lockScreen.verticalOffset
        target.bounds = bounds
    }
}

// MARK: - Content refresh

class SBUIPreciseClockTimer_Hook: ClassHook<SBUIPreciseClockTimer> {
    typealias Group = LockScreen

    func _handleTimePassed() {
        orig._handleTimePassed()
        guard PreferenceManager.shared.settings.lockScreen.isEnabled else { return }
        NotificationCenter.default.post(name: .refreshContent, object: nil)
    }
}

// MARK: - Misc

class CSCoverSheetViewControllerHook: ClassHook<UIViewController> {
    typealias Group = LockScreen
    static var targetName: String = "CSCoverSheetViewController"

    func _transitionChargingViewToVisible(_ arg1: Bool, showBattery arg2: Bool, animated arg3: Bool) {
        orig._transitionChargingViewToVisible(false, showBattery: false, animated: false)
    }
    
    func _transitionChargingDateSubtitleToVisible(_ arg1: Bool, animated arg2: Bool, force arg3: Bool) {
        orig._transitionChargingDateSubtitleToVisible(false, animated: false, force: false)
    }
    
    func viewWillAppear(_ animated: Bool) {
        orig.viewWillAppear(animated)
        guard PreferenceManager.shared.settings.lockScreen.isEnabled,
              PreferenceManager.shared.settings.lockScreen.colorMode == .adaptive,
              let manager = SBLockScreenManager.sharedInstanceIfExists()
        else { return }
        
        let averageColor = manager.averageColorForCurrentWallpaper(
            inScreenRect: .init(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height/2
            )
        )
        LocalState.shared.wallpaperSuitableForegroundColor = averageColor?.suitableForegroundColour()
    }
}

// MARK: - Status bar

class _UIStatusBarStringView_Hook: ClassHook<_UIStatusBarStringView> {
    typealias Group = StatusBar

    // orion: new
    func isTimeLabel() -> Bool {
        // TODO: - The implementation is very dependent on this variable which may change in future iOS versions.
        target.fontStyle == 1
    }

    func applyStyleAttributes(_ arg1: AnyObject) {
        // Adjust the font size, alignment, etc if the label is the time label.
        guard isTimeLabel() else {
            orig.applyStyleAttributes(arg1)
            return
        }
        
        if UIDevice.isFaceIDiPhone {
            target.numberOfLines = 2
            target.textAlignment = .center
        } else {
            target.font = .systemFont(ofSize: 12)
        }
    }

    func setText(_ text: String) {
        // Check if this label is the time label, then add the ram to the label.
        guard isTimeLabel() else {
            orig.setText(text)
            return
        }
        
        let settings = PreferenceManager.shared.settings
        let isEnabledAMPM = settings.statusBar.isEnabledAMPM
        
        let primaryTimeZone = settings.clocks[0].timeZone
        let primaryLocale = settings.clocks[0].locale
        let secondaryTimeZone = settings.clocks[1].timeZone
        let secondaryLocale = settings.clocks[1].locale
        
        guard let primaryTime = isEnabledAMPM
                ? DateTemplate.timeAMPM.dateString(timeZone: primaryTimeZone, locale: primaryLocale)
                : DateTemplate.time.dateString(timeZone: primaryTimeZone, locale: primaryLocale),
              let secondaryTime = isEnabledAMPM
                ? DateTemplate.timeAMPM.dateString(timeZone: secondaryTimeZone, locale: secondaryLocale)
                : DateTemplate.time.dateString(timeZone: secondaryTimeZone, locale: secondaryLocale)
        else {
            orig.setText(text)
            return
        }
        
        guard UIDevice.isFaceIDiPhone else {
            let newText = primaryTime + " - " + secondaryTime
            orig.setText(newText)
            return
        }
        
        let primaryAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)
        ]
        let secondaryAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)
        ]

        let timeString = NSMutableAttributedString(string: "\(primaryTime)\n", attributes: primaryAttributes)
        timeString.append(NSMutableAttributedString(string: secondaryTime, attributes: secondaryAttributes))
        target.attributedText = timeString
    }
}

// MARK: - Preferences

struct DualClock: Tweak {
    init() {
        if readPrefs(),
           PreferenceManager.shared.settings.isEnabled {
            if PreferenceManager.shared.settings.lockScreen.isEnabled, !Dodo().isInstalledAndEnabled {
                LockScreen().activate()
            }
            
            if PreferenceManager.shared.settings.statusBar.isEnabled, !Ecosystem.isInstalled(tweak: .ramUnderTime) {
                StatusBar().activate()
            }
        }
    }
    
    private func prefsDict() -> [String : Any]? {
        let path = "/var/mobile/Library/Preferences/com.ginsu.dualclock2.plist"
        let plistURL = URL(fileURLWithPath: path)
        return plistURL.plistDict()
    }

    private func readPrefs() -> Bool {
        if let dict = prefsDict() {
            PreferenceManager.shared.loadSettings(withDictionary: dict)
            return true
        } else {
            return false
        }
    }
}
