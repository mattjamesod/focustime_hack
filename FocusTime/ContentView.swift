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
            VStack(alignment: .leading) {
                Text("Focus Duration")
                Text("Break Duration")
                Text("Work Hours")
                Text("Lunch")
                Text("Require break before meetings?")
                Text("Require break before meetings?")
            }
            .padding(16)
        }
    }
}
