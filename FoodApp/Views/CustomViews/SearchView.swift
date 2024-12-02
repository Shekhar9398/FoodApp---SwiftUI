import SwiftUI

struct SearchView: View {
    var title : String
    
    @Binding var searchText : String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading)
            
            TextField(title, text: $searchText)
                .foregroundColor(.gray)
        }
        .frame(height: 45)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    SearchView(title: "SearchBar", searchText:.constant(""))
}
