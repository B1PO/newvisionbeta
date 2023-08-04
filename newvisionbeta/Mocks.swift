import Foundation
import Vision

extension VNClassificationObservation: ClassificationObservation {}

struct MockVNClassificationObservation: ClassificationObservation {
    var confidence: VNConfidence
    var identifier: String
}

protocol ClassificationObservation {
    var confidence: VNConfidence { get }
    var identifier: String { get }
}


