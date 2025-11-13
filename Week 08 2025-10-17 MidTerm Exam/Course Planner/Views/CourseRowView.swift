//
//  CourseRowView.swift
//  Course Planner
//
//  Created by user285344 on 10/17/25.
//

import SwiftUI

struct CourseRowView: View {
    let course: Course
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 6){
                Text(course.title)
                    .font(.headline)
                Text(course.instructor)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text(course.level.rawValue)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(.yellow.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal, 25)
    }
}
        

#Preview {
    CourseRowView(course: SampleData.courses[0])}
