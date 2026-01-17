import SwiftUI
import Charts
import UserNotifications

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
            ScrollView() {
                HStack {
                    Spacer()
                    Text("Top Habits")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .padding(.top, 40)
                    Spacer()
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }
                .padding()
                
                VStack(spacing: 30) {
        
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
                                    Text("\(item.name)\(item.name != "Other" ? ": \(item.days)" : "")")
                                        .foregroundColor(.primary)
                                    Image(systemName: "flame.fill")
                                        .foregroundColor(item.check ? .orange : .gray)
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
                    
                    VStack(alignment: .leading) {
                        Text("Summary of 30 days")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        
                        let summaries = habitViewModel.getLast30DaysSummary()
                        
                        Chart(summaries) { day in
                            LineMark(
                                x: .value("Day", day.date),
                                y: .value("Sum", day.totalValue)
                            )
                            PointMark(
                                x: .value("Day", day.date),
                                y: .value("Sum", day.totalValue)
                            )
                        }
                        .background(Color.backgroundMain)
                        .frame(height: 200)
                        .chartXAxis {
                            AxisMarks(values: .stride(by: .day, count: 5)) { value in
                                AxisGridLine()
                                AxisValueLabel(format: .dateTime.day().month(.abbreviated))
                            }
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
            }
            .frame(maxHeight: UIScreen.main.bounds.height * 0.8)
        }
    }
}

