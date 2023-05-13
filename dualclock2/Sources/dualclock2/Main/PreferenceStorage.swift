import Foundation
import Comet

// MARK: - Internal

final class PreferenceStorage: ObservableObject {
    private static let registry: String = "/var/mobile/Library/Preferences/com.ginsu.dualclock2.plist"
    /// Welcome to Comet
    /// By @ginsudev
    ///
    /// Mark your preferences with `@Published(key: "someKey", registry: PreferenceStorage.registry)`.
    /// When the value of these properties are changed, they are also saved into the preferences file on disk to persist changes.
    ///
    /// The initial value you initialise your property with is the fallback / default value that will be used if there is no present value for the
    /// given key.
    ///
    /// `@Published(key: _ registry:_)` properties can only store Foundational types that conform
    /// to `Codable` (i.e. `String, Data, Int, Bool, Double, Float`, etc).

    // Preferences
    @Published(key: "isEnabledTweak", registry: registry) var isEnabled = true
    
    // MARK: - Clocks
    // Primary
    @Published(key: "primaryTimeZoneID", registry: registry) var primaryTimeZoneID = TimeZone.autoupdatingCurrent.identifier
    @Published(key: "primaryLocaleID", registry: registry) var primaryLocaleID = Locale.current.identifier
    @Published(key: "isEnabledCustomTimeZonePrimary", registry: registry) var isEnabledCustomTimeZonePrimary = false
    @Published(key: "primaryName", registry: registry) var primaryName = ""
    
    // Secondary
    @Published(key: "secondaryTimeZoneID", registry: registry) var secondaryTimeZoneID = TimeZone.autoupdatingCurrent.identifier
    @Published(key: "secondaryLocaleID", registry: registry) var secondaryLocaleID = Locale.current.identifier
    @Published(key: "isEnabledCustomTimeZoneSecondary", registry: registry) var isEnabledCustomTimeZoneSecondary = true
    @Published(key: "secondaryName", registry: registry) var secondaryName = ""
    
    @Published(key: "isEnabled24HourMode", registry: registry) var isEnabled24HourMode = false
    
    // MARK: - Lock screen
    @Published(key: "isEnabledLS", registry: registry) var isEnabledLS = true
    @Published(key: "colorMode", registry: registry) var colorMode = 0
    @Published(key: "showSeconds", registry: registry) var showSeconds = false
    @Published(key: "selectedFont", registry: registry) var selectedFont = 2
    @Published(key: "verticalOffset", registry: registry) var verticalOffset = 0.0
    
    // Color
    @Published(key: "secondsColor", registry: registry) var secondsColor = "FFFFFF"
    // Primary
    @Published(key: "primaryNameColor", registry: registry) var primaryNameColor = "FFFFFF"
    @Published(key: "primaryTimeColor", registry: registry) var primaryTimeColor = "FFFFFF"
    @Published(key: "primaryDateColor", registry: registry) var primaryDateColor = "FFFFFF"
    
    // Secondary
    @Published(key: "secondaryNameColor", registry: registry) var secondaryNameColor = "FFFFFF"
    @Published(key: "secondaryTimeColor", registry: registry) var secondaryTimeColor = "FFFFFF"
    @Published(key: "secondaryDateColor", registry: registry) var secondaryDateColor = "FFFFFF"
    
    // Format
    @Published(key: "timeTemplate", registry: registry) var selectedTimeTemplate = 0
    @Published(key: "timeTemplateCustomFormat", registry: registry) var timeTemplateCustomFormat = "h:mm"
    @Published(key: "dateTemplate", registry: registry) var selectedDateTemplate = 0
    @Published(key: "dateTemplateCustomFormat", registry: registry) var dateTemplateCustomFormat = "EEEE, MMMM d"

    // MARK: - Status bar
    @Published(key: "isEnabledSB", registry: registry) var isEnabledSB = false
    @Published(key: "isEnabledAMPM", registry: registry) var isEnabledAMPM = false
}
