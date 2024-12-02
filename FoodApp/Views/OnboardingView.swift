import SwiftUI

struct OnboardingView: View {
    
    let items: [OnboardingModel] = [
        OnboardingModel(title: "Layout", details: "Discover our intuitive and sleek design that makes finding meals easy and enjoyable!", image: "layout"),
        OnboardingModel(title: "Toggle", details: "Easily switch between different food categories and meal options tailored just for you.", image: "toggle"),
        OnboardingModel(title: "Sidebar", details: "Access all your favorite features quickly, from saved dishes to order history, all in one place.", image: "sidebar")
    ]
    
    @Binding var currentIndex: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Iterate through items with ForEach and display only the current index
            ForEach(items.indices) { index in
                if index == currentIndex {
                    Text("\(currentIndex + 1) of \(items.count)")
                        .font(.custom("verdana", size: 20))
                        .fontWeight(.bold)
                    
                    Text(items[index].title)
                        .font(.custom("verdana", size: 20))
                        .fontWeight(.bold)
                    
                    Text(items[index].details)
                        .font(.custom("verdana", size: 18))
                    
                    Image(items[index].image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 280, height: 400)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(25)
                }
            }
            .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            
            Spacer()
            
            // Next Button with boundary check
            GradientButton(title: "Next") {
                    withAnimation {
                        currentIndex += 1
                    }
            }
            .padding(.leading, 40)
            
            Spacer()
        }
        .padding()
    }
}




// Preview code
#Preview("Onboarding Preview") {
    OnboardingView(currentIndex: .constant(0))
}
