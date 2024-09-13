import SwiftUI

@MainActor
struct ContentView: View {
    @State var viewModel = SettingsViewModel()
    @State var showingSettingsPane: Bool = false
    
    var body: some View {
        TimerContainerView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .topTrailing) {
                Button {
                    showingSettingsPane.toggle()
                } label: {
                    Label("Settings", systemImage: "gear")
                }
                .labelStyle(.iconOnly)
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $showingSettingsPane) {
                SettingsContainerView()
                    .presentationCornerRadius(24)
            }
            .task {
                await viewModel.setDefaults()
                await viewModel.load()
            }
            .environment(viewModel)
        
    }
}

enum UserTimingKey: String {
    case focusDuration = "focusDuration"
    case breakDuration = "breakDuration"
    case workHours = "workHours"
    case lunch = "lunch"
}

@MainActor @Observable
class SettingsViewModel {
    let defaults = UserDefaults.standard
    
    var loaded: Bool = false
    
    var focusDuration: Int?
    var breakDuration: Int?
    var workingHoursStart: Date?
    var workingHoursEnd: Date?
    var lunchStart: Date?
    var lunchEnd: Date?

    private let focusDurationDeafult: Int = 45
    private let breakDurationDeafult: Int = 7
    private let workingHoursStartDeafult: Double = Date.now.atTime(h: 9, m: 0, s: 0).timeIntervalSince1970
    private let workingHoursEndDeafult: Double = Date.now.atTime(h: 17, m: 0, s: 0).timeIntervalSince1970
    private let lunchStartDeafult: Double = Date.now.atTime(h: 13, m: 0, s: 0).timeIntervalSince1970
    private let lunchEndDeafult: Double = Date.now.atTime(h: 14, m: 0, s: 0).timeIntervalSince1970
    
    func load() async {
        focusDuration = defaults.integer(forKey: UserTimingKey.focusDuration.rawValue)
        breakDuration = defaults.integer(forKey: UserTimingKey.breakDuration.rawValue)
        
        workingHoursStart = Date(timeIntervalSince1970: defaults.double(forKey: UserTimingKey.workHours.rawValue + "Start"))
        workingHoursEnd = Date(timeIntervalSince1970: defaults.double(forKey: UserTimingKey.workHours.rawValue + "End"))
        
        lunchStart = Date(timeIntervalSince1970: defaults.double(forKey: UserTimingKey.lunch.rawValue + "Start"))
        lunchEnd = Date(timeIntervalSince1970: defaults.double(forKey: UserTimingKey.lunch.rawValue + "End"))
        
        loaded = true
    }
    
    func save() async {
        defaults.setValue(self.focusDuration!, forKey: UserTimingKey.focusDuration.rawValue)
        defaults.setValue(self.breakDuration!, forKey: UserTimingKey.breakDuration.rawValue)
        
        defaults.setValue(self.workingHoursStart!.timeIntervalSince1970, forKey: UserTimingKey.workHours.rawValue + "Start")
        defaults.setValue(self.workingHoursEnd!.timeIntervalSince1970, forKey: UserTimingKey.workHours.rawValue + "End")
        
        defaults.setValue(self.lunchStart!.timeIntervalSince1970, forKey: UserTimingKey.lunch.rawValue + "Start")
        defaults.setValue(self.lunchEnd!.timeIntervalSince1970, forKey: UserTimingKey.lunch.rawValue + "End")
    }
    
    func setDefaults() async {
        guard !defaults.bool(forKey: "FIRST_SETUP_DONE") else { return }
        
        defaults.setValue(self.focusDurationDeafult, forKey: UserTimingKey.focusDuration.rawValue)
        defaults.setValue(self.breakDurationDeafult, forKey: UserTimingKey.breakDuration.rawValue)
        
        defaults.setValue(self.workingHoursStartDeafult, forKey: UserTimingKey.workHours.rawValue + "Start")
        defaults.setValue(self.workingHoursEndDeafult, forKey: UserTimingKey.workHours.rawValue + "End")
        
        defaults.setValue(self.lunchStartDeafult, forKey: UserTimingKey.lunch.rawValue + "Start")
        defaults.setValue(self.lunchEndDeafult, forKey: UserTimingKey.lunch.rawValue + "End")
        
        defaults.setValue(true, forKey: "FIRST_SETUP_DONE")
    }
}

struct SettingsContainerView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Settings_")
                .font(.largeTitle)
                .fontDesign(.monospaced)
                .fontWeight(.semibold)
                .padding(.vertical, 24)
            
            Divider()
            
            SettingsListView()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SettingsListView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                FocusDurationPickerSettingView()
                BreakDurationPickerSettingView()
                WorkHoursPickerSettingView()
                LunchPickerSettingView()
            }
            .padding(16)
        }
    }
}

extension View {
    func focusTimeHeadingStyle() -> some View {
        self
            .font(.title3)
            .fontDesign(.monospaced)
            .fontWeight(.medium)
    }
}


