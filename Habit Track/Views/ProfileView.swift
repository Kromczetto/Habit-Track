import SwiftUI
import Charts

struct ProfileView: View {
    @State private var habitCounter: Int = 0
    
    @ObservedObject var habitViewModel: HabitViewModel
    @ObservedObject var habitStatisticsViewModel: HabitStatisticsViewModel
        
    init(habitViewModel: HabitViewModel) {
        self.habitViewModel = habitViewModel
        self.habitStatisticsViewModel = HabitStatisticsViewModel(habitViewModel: habitViewModel)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundMain
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Top Habits")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding(.top, 40)
                
                Chart {
                    ForEach(habitStatisticsViewModel.topHabitsWithOther()) { item in
                        SectorMark(
                            angle: .value("Days", item.days),
                            innerRadius: .ratio(0.5)
                        )
                        .foregroundStyle(item.color)
                    }
                }
                .frame(height: 250)
                .padding()

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(habitStatisticsViewModel.topHabitsWithOther()) { item in
                        HStack {
                            if item.days > 0 {
                                Circle()
                                    .fill(item.color)
                                    .frame(width: 16, height: 16)
                                    Text("\(item.name)\(item.name != "Other" ? ": \(item.days) 🔥" : "")")
                                        .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .padding()
                
                Text("Today's Completed Weight: \(habitStatisticsViewModel.totalWeightForToday())")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .onAppear {
                        habitViewModel.fetchData()
                    }
                
                Spacer()
            }
            .padding()
        }
    }
}

