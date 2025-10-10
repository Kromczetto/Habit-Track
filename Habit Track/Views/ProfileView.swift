import SwiftUI
import Charts

struct ProfileView: View {
    @ObservedObject var habitViewModel: HabitViewModel
    @ObservedObject var statisticsVM: HabitStatisticsViewModel
        
    init(habitViewModel: HabitViewModel) {
        self.habitViewModel = habitViewModel
        self.statisticsVM = HabitStatisticsViewModel(habitViewModel: habitViewModel)
    }
    
    var body: some View {
        ZStack {
            Color.backgroundMain
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Top 5 Habits")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding(.top, 40)
                
                Chart {
                    ForEach(statisticsVM.topHabitsWithOther()) { item in
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
                    ForEach(statisticsVM.topHabitsWithOther()) { item in
                        HStack {
                            Circle()
                                .fill(item.color)
                                .frame(width: 16, height: 16)
                            Text("\(item.name): \(item.days) days")
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
                
                Text("Today's Completed Weight: \(statisticsVM.totalWeightForToday())")
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

