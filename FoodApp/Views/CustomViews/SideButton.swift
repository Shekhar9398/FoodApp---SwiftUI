import SwiftUI

struct SideButton: View {
    
    var iconName: String
    var title: String
    
    @Binding var isDarkMode: Bool // Binding to track mode change
    
    var action: () -> Void // Action to trigger on button press
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(isDarkMode ? .white : .black) // Change icon color based on dark/light mode
                
                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(isDarkMode ? .white : .black) // Change text color based on dark/light mode
            }
            .padding(.leading)
            .frame(width: 200, height: 50, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 0.7)
                    .foregroundColor(isDarkMode ? .white.opacity(0.2) : .black.opacity(0.2)) // Border color based on mode
            )
        }
    }
}
#Preview {
    SideButton(iconName: "house", title: "Home", isDarkMode: .constant(false), action: {})
}
