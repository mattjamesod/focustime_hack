import SwiftUI

struct ContentView: View {
    @State var showingSettingsPane: Bool = true
    
    var body: some View {
        Text("MAIN UI")
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
                DurationPickerSettingView("Focus Duration", default: 45)
                DurationPickerSettingView("Break Duration", default: 7)
                StartEndPickerSettingView("Work Hours")
                StartEndPickerSettingView("Lunch", start: Date.now.atTime(h: 13, m: 0, s: 0), end: Date.now.atTime(h: 14, m: 0, s: 0))
//                ToggleSettingView("Break before meetings?")
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


struct DurationPickerSettingView: View {
    let title: String
    
    @State var minutes: Int
    
    init(_ title: String, default defaultVal: Int) {
        self.title = title
        
        self._minutes = State(initialValue: defaultVal)
    }
    
    var body: some View {
        VStack {
            Text(title)
                .focusTimeHeadingStyle()
            
            VStack {
                Stepper("**\(minutes)** Minutes", value: $minutes)
                    .padding(.leading, 18)
                    .padding(.trailing, 12)
            }
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundStyle(.ultraThinMaterial)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct StartEndPickerSettingView: View {
    let title: String
    
    @State var startDate: Date
    @State var endDate: Date
    
    init(_ title: String, start: Date = Date.now.atTime(h: 9, m: 0, s: 0), end: Date = Date.now.atTime(h: 17, m: 0, s: 0)) {
        self.title = title
        
        self._startDate = State(initialValue: start)
        self._endDate = State(initialValue: end)
    }
    
    var body: some View {
        VStack {
            Text(title)
                .focusTimeHeadingStyle()
            
            VStack {
                DatePicker("Start", selection: $startDate, displayedComponents: [.hourAndMinute])
                    .padding(.leading, 18)
                    .padding(.trailing, 12)
                Divider()
                DatePicker("End", selection: $endDate, displayedComponents: [.hourAndMinute])
                    .padding(.leading, 18)
                    .padding(.trailing, 12)
            }
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundStyle(.ultraThinMaterial)
            }
            .padding(.horizontal, 24)
        }
    }
}

struct ToggleSettingView: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .focusTimeHeadingStyle()
    }
}
