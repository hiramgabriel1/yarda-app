import SwiftUI

enum OnboardingStep {
    case school
    case name
    case role
    case setupStore
    case complete
}

struct OnboardingContainer: View {
    @State private var currentStep: OnboardingStep = .school
    @State private var selectedSchool: String?
    @State private var selectedRole: UserRole?

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
                    selectedRole: $selectedRole,
                    onContinue: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            if selectedRole == .seller || selectedRole == .both {
                                currentStep = .setupStore
                            } else {
                                currentStep = .complete
                            }
                        }
                    },
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .name
                        }
                    }
                )
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .setupStore:
                SetupStoreView(
                    onContinue: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .complete
                        }
                    },
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentStep = .role
                        }
                    }
                )
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .complete:
                HomeView()
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentStep)
    }
}
