import SwiftUI

struct FocusDurationPickerSettingView: View {
    @State var minutes: Int = 0
    @Environment(SettingsViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            Text("Focus Duration")
                .focusTimeHeadingStyle()
            
            VStack {
                Stepper("**\(minutes)** Minutes", value: $minutes)
                    .padding(.leading, 18)
                    .padding(.trailing, 12)
                    .onChange(of: self.minutes) {
                        viewModel.focusDuration = minutes
                        
                        Task.detached {
                            await viewModel.save()
                        }
                    }
            }
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundStyle(.ultraThinMaterial)
            }
            .padding(.horizontal, 24)
        }
        .onAppear {
            self.minutes = viewModel.focusDuration!
        }
    }
}

struct BreakDurationPickerSettingView: View {
    @State var minutes: Int = 0
    @Environment(SettingsViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            Text("Break Duration")
                .focusTimeHeadingStyle()
            
            VStack {
                Stepper("**\(minutes)** Minutes", value: $minutes)
                    .padding(.leading, 18)
                    .padding(.trailing, 12)
                    .onChange(of: self.minutes) {
                        viewModel.breakDuration = minutes
                        
                        Task.detached {
                            await viewModel.save()
                        }
                    }
            }
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundStyle(.ultraThinMaterial)
            }
            .padding(.horizontal, 24)
        }
        .onAppear {
            self.minutes = viewModel.breakDuration!
        }
    }
}

struct WorkHoursPickerSettingView: View {
    @State var startDate: Date = .now
    @State var endDate: Date = .now
    
    @Environment(SettingsViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            Text("Work Hours")
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
            .onChange(of: self.startDate) {
                viewModel.workingHoursStart = startDate
                
                Task.detached {
                    await viewModel.save()
                }
            }
            .onChange(of: self.endDate) {
                viewModel.workingHoursEnd = endDate
                
                Task.detached {
                    await viewModel.save()
                }
            }
        }
        .onAppear {
            self.startDate = viewModel.workingHoursStart!
            self.endDate = viewModel.workingHoursEnd!
            
        }
    }
}

struct LunchPickerSettingView: View {
    @State var startDate: Date = .now
    @State var endDate: Date = .now
    
    @Environment(SettingsViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            Text("Lunch")
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
            .onChange(of: self.startDate) {
                viewModel.lunchStart = startDate
                
                Task.detached {
                    await viewModel.save()
                }
            }
            .onChange(of: self.endDate) {
                viewModel.lunchEnd = endDate
                
                Task.detached {
                    await viewModel.save()
                }
            }
        }
        .onAppear {
            self.startDate = viewModel.lunchStart!
            self.endDate = viewModel.lunchEnd!
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
