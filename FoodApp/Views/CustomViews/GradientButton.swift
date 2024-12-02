import SwiftUI
struct GradientButton: View {
    
    var gradientColors = Gradient(colors: [.red, .yellow, .green, .blue, .purple, .pink, .purple])
    
    @State private var isAnimating = false
    @State private var isPressed = false
    
    // Make the button reusable
    var title: String
    var action: () -> Void
    
    var body: some View {
        ZStack {
            // Blur effect
            RoundedRectangle(cornerRadius: 20)
                .stroke(AngularGradient(gradient: gradientColors, center: .center, angle: .degrees(0)), lineWidth: 14)
                .blur(radius: 20)
                .frame(width: 280, height: 60)
            
            // Button text and background
            Text(title)
                .frame(width: 280, height: 60)
                .font(.title)
                .background(.black, in: RoundedRectangle(cornerRadius: 20))
                .foregroundColor(.white)
            
                // Animation Effect
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(AngularGradient(gradient: gradientColors, center: .center, angle: .degrees(isAnimating ? 360 : 0)), lineWidth: 4)
                }
        }
        // Start the animation
        .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                isAnimating = true
            }
        }
        
        // Set scale effect
        .scaleEffect(isPressed ? 0.9 : 1)
        .animation(.easeInOut(duration: 0.3), value: isPressed)
        
        // Handle press effect and action with simultaneous gesture
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0)
                .onChanged { _ in
                    isPressed = true
                }
                .onEnded { _ in
                    isPressed = false
                    action() // Call action on tap release
                }
        )
    }
}

#Preview {
    GradientButton(title: "Button", action: {
        print("Button Pressed")
    })
}
