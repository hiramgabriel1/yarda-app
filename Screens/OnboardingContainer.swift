import SwiftUI

enum OnboardingStep {
    case school
    case name
    case role
    case complete
}

struct OnboardingContainer: View {
    @State private var currentStep: OnboardingStep = .school
    @State private var selectedSchool: String?

    var body: some View {
        ZStack {
            switch currentStep {
            case .school:
                OnboardingSchoolView(
                    selectedSchool: $selectedSchool,
                    onContinue: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .name
                        }
                    }
                )
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .name:
                OnboardingNameView(
                    onContinue: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .role
                        }
                    },
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .school
                        }
                    }
                )
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .role:
                OnboardingRoleView(
                    onContinue: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .complete
                        }
                    },
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .name
                        }
                    }
                )
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .complete:
                Text("Onboarding completo")
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentStep)
    }
}
