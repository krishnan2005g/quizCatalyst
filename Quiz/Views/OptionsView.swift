import SwiftUI

struct OptionsView: View {
    let options: [String]
    let onTap: (String) -> Void
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            ForEach(options, id: \.self) { option in
                OptionButtonView(optionText: option)
            }
        }
    }

    func OptionButtonView(optionText: String) -> some View {
        Button(action: {
                onTap(optionText)
        }) {
            Text(optionText)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .padding(.horizontal, 22)
                .frame(maxWidth: 300, maxHeight: 220)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black, Color.black.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .cornerRadius(12) 
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.3), lineWidth: 2) // Soft white border
                )
                .multilineTextAlignment(.leading) // Center-align text
                .lineLimit(nil) // Allow text to wrap
        }
    }
}

#Preview {
    OptionsView(options: ["Option A", "This is a longer option that will wrap into multiple lines.his is a longer option that will wrap into multiple lines.", "Option C", "Option D"], onTap: { _ in })
}
