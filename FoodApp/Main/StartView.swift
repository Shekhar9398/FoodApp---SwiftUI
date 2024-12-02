import SwiftUI

struct StartView: View {
    
    @State private var currentIndex = 0
    
    var body: some View {
        if currentIndex < 3 {
            OnboardingView(currentIndex: $currentIndex)
                .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
        } else {
            HomeView(cartViewModel: CartViewModel()) 
        }
    }
}

// Preview code
#Preview("Start View Preview") {
    StartView()
}
