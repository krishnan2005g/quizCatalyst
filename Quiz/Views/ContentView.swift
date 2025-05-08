import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack(spacing: 30) {
            QuizOneByOneView()
        }
    }
}

#Preview {
    ContentView()
}



struct QuizOneByOneView: View {
    @State private var model = QuizModel()
    @State private var selectedOption: String? = nil
    @State private var isCorrect: Bool? = nil
    @State private var isOptionTapped: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            if let q = model.currentQuestion {
                Text(q.Question)
                    .font(.title2)
                    .multilineTextAlignment(.center)

                ForEach([q.Option_1, q.Option_2, q.Option_3, q.Option_4], id: \.self) { option in
                    Button(action: {
                        if !isOptionTapped {
                            selectedOption = option
                            isCorrect = (option == q.Answer)
                            isOptionTapped = true

                            // Move to next question after 1.5 sec
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                model.next()
                                selectedOption = nil
                                isCorrect = nil
                                isOptionTapped = false 
                            }
                        }
                    }) {
                        HStack {
                            Text(option)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if selectedOption == option {
                                Image(systemName: isCorrect == true ? "checkmark.circle" : "xmark.circle")
                                    .foregroundColor(isCorrect == true ? .green : .red)
                            }
                        }
                        .padding()
                        .background(
                            selectedOption == option
                                ? (isCorrect == true ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                                : Color.gray.opacity(0.1)
                        )
                        .cornerRadius(8)
                    }
                    .disabled(isOptionTapped)
                }

                Spacer()

                HStack {
                    Spacer()
                    Button("Back") {
                        model.back()
                        selectedOption = nil
                        isCorrect = nil
                        isOptionTapped = false
                    }
                    .disabled(model.currentIndex == 0 || isOptionTapped)
                    Spacer()
                    Button("Next") {
                        model.next()
                        selectedOption = nil
                        isCorrect = nil
                        isOptionTapped = false
                    }
                    .disabled(model.currentIndex == model.questions.count - 1 || isOptionTapped)
                    Spacer()
                }
            } else {
                Text("Loading...")
            }
        }
        .padding()
        .onAppear {
            model.fetchQuestions()
        }
    }
}
