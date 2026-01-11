import libopus
import Foundation

/// Application mode for the Opus encoder.
enum Application: RawRepresentable {
    /// Best for broadcast/high-fidelity application where the decoded audio should be as close as possible to the input
    case audio
    /// Best for most VoIP/videoconference applications where listening quality and intelligibility matter most
    case voip
    /// Only use when lowest-achievable latency is what matters most. Voice-optimized modes cannot be used.
    case restrictedLowDelay

    init?(rawValue: Int32) {
        switch rawValue {
        case OPUS_APPLICATION_AUDIO:
            self = .audio
        case OPUS_APPLICATION_VOIP:
            self = .voip
        case OPUS_APPLICATION_RESTRICTED_LOWDELAY:
            self = .restrictedLowDelay
        default:
            return nil
        }
    }

    var rawValue: Int32 {
        switch self {
        case .audio:
            return OPUS_APPLICATION_AUDIO
        case .voip:
            return OPUS_APPLICATION_VOIP
        case .restrictedLowDelay:
            return OPUS_APPLICATION_RESTRICTED_LOWDELAY
        }
    }
}

enum Channels: Int32 {
    case mono = 1
    case stereo = 2
}
