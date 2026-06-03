import SwiftUI

struct OnboardingSchoolView: View {
    @State private var selectedSchool: String? = "IPN"
    @State private var searchText = ""

    let popularSchools = [
        School(name: "UNAM", type: "Universidad", location: "Ciudad de México", isSelected: false),
        School(name: "IPN", type: "Universidad", location: "Ciudad de México", isSelected: true),
        School(name: "Tec de Monterrey", type: "Universidad", location: "Monterrey", isSelected: false),
        School(name: "UAM", type: "Universidad", location: "Ciudad de México", isSelected: false),
        School(name: "ITAM", type: "Universidad", location: "Ciudad de México", isSelected: false),
        School(name: "Iberoamericana", type: "Universidad", location: "Ciudad de México", isSelected: false),
        School(name: "BUAP", type: "Universidad", location: "Puebla", isSelected: false),
        School(name: "UDG", type: "Universidad", location: "Guadalajara", isSelected: false),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                headerSection

                searchSection

                popularSectionHeader

                popularSchoolsList

                footerSection
            }
        }
        .background(AppTheme.background)
        .navigationBarHidden(true)
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AppTheme.primary)
                        .frame(width: 32, height: 32)

                    Image(systemName: "bag.fill")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(AppTheme.primaryForeground)
                }

                Text("Marketu")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(AppTheme.foreground)
                    .tracking(-0.3)
            }
            .padding(.bottom, 32)

            Text("PASO 1 DE 3")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(AppTheme.primary)
                .tracking(0.8)
                .padding(.bottom, 4)

            Text("¿Dónde estudias?")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(AppTheme.foreground)
                .tracking(-0.5)
                .lineSpacing(1.15)
                .padding(.bottom, 8)

            Text("Conéctate con vendedores de tu escuela.")
                .font(.system(size: 15))
                .foregroundStyle(AppTheme.mutedForeground)
                .lineSpacing(1.5)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 16)
    }

    private var searchSection: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(AppTheme.mutedForeground)

            Text("Busca tu universidad o preparatoria")
                .font(.system(size: 15))
                .foregroundStyle(AppTheme.mutedForeground)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(AppTheme.input)
        .cornerRadius(16)
        .padding(.horizontal, 24)
        .padding(.bottom, 16)
    }

    private var popularSectionHeader: some View {
        Text("POPULARES")
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(AppTheme.mutedForeground)
            .tracking(0.6)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
    }

    private var popularSchoolsList: some View {
        VStack(spacing: 0) {
            ForEach(popularSchools) { school in
                let isSelected = selectedSchool == school.name
                SchoolListItem(
                    school: School(
                        name: school.name,
                        type: school.type,
                        location: school.location,
                        isSelected: isSelected
                    )
                ) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        if selectedSchool == school.name {
                            selectedSchool = nil
                        } else {
                            selectedSchool = school.name
                        }
                    }
                }

                if school != popularSchools.last {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(AppTheme.border)
                        .padding(.leading, 64)
                }
            }
        }
        .background(AppTheme.card)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 1.5, x: 0, y: 1)
        .padding(.horizontal, 16)
    }

    private var footerSection: some View {
        VStack(spacing: 0) {
            Button(action: {}) {
                HStack(spacing: 8) {
                    Text("Continuar")
                        .font(.system(size: 15, weight: .semibold))
                        .tracking(-0.1)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold))
                }
                .foregroundStyle(AppTheme.primaryForeground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(AppTheme.primary)
                .cornerRadius(16)
                .shadow(color: AppTheme.primary.opacity(0.3), radius: 14, x: 0, y: 4)
            }
            .buttonStyle(.plain)

            HStack(spacing: 0) {
                Text("¿No encuentras tu escuela? ")
                    .font(.system(size: 12))
                    .foregroundStyle(AppTheme.mutedForeground)

                Text("Sugiérela aquí")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(AppTheme.primary)
            }
            .padding(.top, 12)
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 60)
    }
}

#Preview {
    OnboardingSchoolView()
}
