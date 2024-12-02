import SwiftUI

struct SideMenuView: View {
    // Using @AppStorage to persist dark mode setting
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false // Default to light mode if no preference
    
   @Binding var selection : viewSelection
        
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Spacer()
                        
            // Home Button
            SideButton(iconName: "house", title: "Home", isDarkMode: $isDarkMode, action: {
                selection = .home
            })
            
            // Purchase Button with navigation
            SideButton(iconName: "cart", title: "Purchase", isDarkMode: $isDarkMode, action: {
                selection = .cart
            })
            
            // Favorites Button
            SideButton(iconName: "star", title: "Favorites", isDarkMode: $isDarkMode, action: {
                selection = .favorites
            })
            
            // Trash Button
            SideButton(iconName: "trash", title: "Trash", isDarkMode: $isDarkMode, action: {
                selection = .trash
            })
            
            // Dark/Light Mode Toggle
            Toggle(isOn: $isDarkMode) {
                Text("Dark Mode")
                    .font(.subheadline)
                    .foregroundColor(isDarkMode ? .white : .black)
            }
            .padding()
            
            Spacer()
                    
        }
        .ignoresSafeArea()
        .padding()
        .background(isDarkMode ? Color.black : Color.white) // Set background color based on dark mode
        .preferredColorScheme(isDarkMode ? .dark : .light) // Set the app-wide color scheme
    }
}

// Preview
struct SideMenuView_Preview: PreviewProvider {
    static var previews: some View {
        SideMenuView(selection: .constant(.home))
            .previewLayout(.sizeThatFits) // Adjust the preview size
    }
}
