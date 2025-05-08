import Foundation
import Observation

@Observable
class QuizModel {
    var questions: [QuizQuestion] = []
    var currentIndex: Int = 0

    var currentQuestion: QuizQuestion? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    func fetchQuestions() {
        guard let url = URL(string: "https://quiz-60040580931.development.catalystserverless.in/server/quiz/data") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("API error:", error?.localizedDescription ?? "Unknown error")
                return
            }

            do {
                let decoded = try JSONDecoder().decode([QuizQuestion].self, from: data)
                DispatchQueue.main.async {
                    self.questions = decoded
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }

    func next() {
        if currentIndex + 1 < questions.count {
            currentIndex += 1
        }
    }
    
    func back() {
        if currentIndex - 1 > -1 {
            currentIndex -= 1
        }
    }
}
