# Habit Track

**Habit Track** is an iOS application designed to help users build, prioritize, and maintain positive routines. Each habit is assigned a numerical value representing its priority. At the end of each day, completed habits are summed into a daily score that reflects how effectively the user focused on their most important goals.

The app goes beyond basic habit tracking by offering streaks, weighted habits, and visual statistics to support consistency and motivation over time.

---

## Features

- **Add, edit, and delete habits**
- **Assign a priority score (weight)** to each habit
- **Daily summary** showing the total score of completed habits
- **Habit notifications
- **Streak tracking**: consecutive execution of habits, reset if a day is missed
- **Statistics** with pie charts showing streaks of top habits
- **Daily view** with list of habits completed today
- **Interactive checkmarks** to mark habits as done once per day
- **iCloud synchronization** for secure backups (planned)
- **Export data** to CSV or PDF (planned)

---

## How It Works

1. **Adding a Habit:**  
   - Enter habit name and assign a priority score (weight).  
   - Habit is saved and appears in the main list.

2. **Completing Habits:**  
   - Tap the checkmark next to a habit to mark it as done for the day.  
   - A habit can be completed **only once per day**.  
   - Completed habits contribute their **weight** to the daily score.

3. **Streaks:**  
   - Streaks track consecutive days a habit has been completed.  
   - Missing a day resets the streak to zero.  
   - Pie charts visualize streaks for top habits, with “Other” representing remaining habits.

4. **Statistics & Daily Summary:**  
   - Pie chart shows top 5 habits by streak.  
   - Daily summary shows total completed weight and list of habits done today.

---

## Technical Details

- **Platform:** iOS 16+  
- **Language:** Swift  
- **UI Framework:** SwiftUI  
- **Data Storage:** SwiftData  
- **Architecture:** MVVM 
- **Charts:** Swift Charts

---

## Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/HabitTrack.git
cd HabitTrack
