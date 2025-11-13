//
//  CourseDetailView.swift
//  Course Planner
//
//  Created by user285344 on 10/17/25.
//

import SwiftUI

struct CourseDetailView: View {
    let course: Course // passed in from NavigationLink
    @State private var isEnrolled = false // local state for the toggle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text(course.title)
                .font(.title)
            Text("Instructed by: \(course.instructor)")
                .font(.title2)
            Text("Level:  \(course.level.rawValue)")
                             
            Text("Hours:  \(course.hours)")
                .foregroundStyle(.secondary)
            Text(course.summary)
            
            // --- The Toggle ---
            Toggle("Enroll (local only)", isOn: $isEnrolled)
            
            // Simple feedback based on the toggle state
            if isEnrolled {
                Text("✅ You are enrolled in this course.")
                    .font(.subheadline)
            } else {
                Text("❌ You are not enrolled.")
                    .font(.subheadline)
            }
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Course Details")
    }
}

#Preview {
    CourseDetailView(course: SampleData.courses[0])
}
