//
//  CoursesView.swift
//  Course Planner
//
//  Created by user285344 on 10/17/25.
//

import SwiftUI

struct CoursesView: View {
    let courses = SampleData.courses

    var body: some View {
        NavigationView {
            VStack() {
                HStack(alignment: .center) {
                    Button("All") {}
                        .padding(.horizontal, 10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1))

                    Button("Beginner") {}
                        .padding(.horizontal, 10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1))
                    
                    Button("Intermediate") {}
                        .padding(.horizontal, 10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1))

                    Button("Advanced") {}
                        .padding(.horizontal, 10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1))
                }
                
                List(courses){ course in
                    NavigationLink(destination: CourseDetailView(course: course)) {
                    CourseRowView(course: course)
                    }
                }
                
                }
                .navigationTitle("Courses")
            }
        }
    }

#Preview {
    CoursesView()
}
