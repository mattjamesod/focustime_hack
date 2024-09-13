import SwiftUI

@MainActor
struct TimerContainerView: View {
    @Environment(SettingsViewModel.self) var viewModel
    
    var body: some View {
        Group {
            if viewModel.loaded {
                TimerQueueView()
            }
            else {
                ProgressView()
            }
        }
    }
}

struct TimerQueueView: View {
    @Environment(SettingsViewModel.self) var viewModel
    
    var body: some View {
        CenteredScrollView {
            VStack(spacing: 48) {
                TimerView(totalSeconds: viewModel.focusDuration! * 60)
                
                VStack {
                    Text("Up Next")
                        .focusTimeHeadingStyle()
                    
                    QueuedTimerView()
                }
            }
        }
    }
}

struct QueuedTimerView: View {
    var body: some View {
        HStack {
            DummyTimerView(counter: "7:00")
            Text("Break")
                .fontDesign(.monospaced)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding(16)
    }
}

struct TimerView: View {
    @Environment(SettingsViewModel.self) var viewModel
    @ScaledMetric var countdownScale: Double = 1.5
    
    @State var secondsRemaining: Int = 0
    let totalSeconds: Int
    
    init(totalSeconds: Int) {
//        self._secondsRemaining = State(initialValue: totalSeconds)
        self.totalSeconds = totalSeconds
    }

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var countdownFraction: Double {
        Double(secondsRemaining) / Double(totalSeconds)
    }
    
    var counter: String {
        let seconds = totalSeconds - secondsRemaining
        let minutes = seconds/60
        let remainder = seconds%60
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumIntegerDigits = 2

        let number = NSNumber(value: remainder)
        let formattedValue = formatter.string(from: number)!
        
        return "\(minutes):\(formattedValue)"
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.ultraThinMaterial, lineWidth: 18)
                .padding(.horizontal, 36)
            
            Circle()
                .trim(from: 0, to: 1 - countdownFraction)
                .stroke(.blue,
                    style: StrokeStyle(
                        lineWidth: 18,
                        lineCap: .round
                    )
                )
                .rotationEffect(.radians(1 * -0.5 * .pi))
                .rotationEffect(.radians(countdownFraction * 2 * .pi))
                .foregroundStyle(.blue)
                .padding(.horizontal, 36)
            
            Text(counter)
                .contentTransition(.numericText(countsDown: true))
                .font(.largeTitle)
                .fontWeight(.black)
                .fontDesign(.monospaced)
                .foregroundStyle(.gray)
                .scaleEffect(countdownScale)
        }
        .onReceive(timer) { _ in
            if totalSeconds - secondsRemaining > 0 {
                withAnimation {
                    secondsRemaining += 1
                }
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        
        return formatter
    }
}

struct DummyTimerView: View {
    let counter: String
    
    var body: some View {
    	ZStack {
    	    Circle()
    	        .stroke(.blue,
    	            style: StrokeStyle(
    	                lineWidth: 6,
    	                lineCap: .round
    	            )
    	        )
    	        .foregroundStyle(.blue)
                .frame(maxWidth: 60)
//    	        .padding(.horizontal, 18)
    	    
    	    Text(counter)
                .font(.caption)
    	        .fontWeight(.bold)
    	        .fontDesign(.monospaced)
    	        .foregroundStyle(.gray)
                .scaleEffect(1.5)
    	}
    }
}


struct CenteredScrollView<Content: View>: View {
    let contentBuilder: () -> Content
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                contentBuilder()
                    .frame(minHeight: proxy.size.height)
            }
        }
    }
}
