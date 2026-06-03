import SwiftUI

struct School: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let type: String
    let location: String
    let isSelected: Bool

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct SchoolListItem: View {
    let school: School
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(school.isSelected ? AppTheme.brandPrimary : AppTheme.brandSecondary)
                        .frame(width: 40, height: 40)

                    Image(systemName: "graduationcap.fill")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(school.isSelected ? AppTheme.brandPrimaryForeground : AppTheme.brandSecondaryForeground)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(school.name)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(school.isSelected ? AppTheme.brandPrimary : AppTheme.foreground)

                    Text("\(school.type) · \(school.location)")
                        .font(.system(size: 12))
                        .foregroundStyle(AppTheme.mutedForeground)
                }

                Spacer()

                if school.isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(AppTheme.brandPrimary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack {
        SchoolListItem(school: School(name: "UNAM", type: "Universidad", location: "Ciudad de México", isSelected: false)) {}
        Rectangle().frame(height: 1).foregroundStyle(AppTheme.border).padding(.leading, 64)
        SchoolListItem(school: School(name: "IPN", type: "Universidad", location: "Ciudad de México", isSelected: true)) {}
    }
    .background(AppTheme.card)
}
