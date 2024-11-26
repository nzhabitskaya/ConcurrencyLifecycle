//
//  FirstTabView.swift
//  LifecycleConcurrency
//
//

import SwiftUI

struct FirstTabView: View {
    
    @State var title = "View One"
    
    var body: some View {
        Text(title)
            .onAppear(perform: {
                print("onAppear triggered")
            })
            .onDisappear(perform: {
                print("onDisappeared triggered")
            })
            .task(priority: .background) {
                title = await changeTitle()
            }
    }
    
    func changeTitle() async -> String {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        return "Async task complete"
    }
}


extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}

#Preview {
    FirstTabView()
}
