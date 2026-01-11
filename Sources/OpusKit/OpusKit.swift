import libopus
import Foundation

/// Application mode for the Opus encoder.
public enum Application: RawRepresentable {
    /// Best for broadcast/high-fidelity application where the decoded audio should be as close as possible to the input
    case audio
    /// Best for most VoIP/videoconference applications where listening quality and intelligibility matter most
    case voip
    /// Only use when lowest-achievable latency is what matters most. Voice-optimized modes cannot be used.
    case restrictedLowDelay

    public init?(rawValue: Int32) {
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

    public var rawValue: Int32 {
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

public enum Channels: Int32 {
    case mono = 1
    case stereo = 2
}

public enum SampleRate: Int32 {
    case `8000` = 8000
    case `12000` = 12000
    case `16000` = 16000
    case `24000` = 24000
    case `48000` = 48000
}

public enum Signal: RawRepresentable {
    case auto
    case voice
    case music

    public init?(rawValue: Int32) {
        switch rawValue {
        case OPUS_AUTO:
            self = .auto
        case OPUS_SIGNAL_VOICE:
            self = .voice
        case OPUS_SIGNAL_MUSIC:
            self = .music
        default:
            return nil
        }
    }

    public var rawValue: Int32 {
        switch self {
        case .auto:
            return OPUS_AUTO
        case .voice:
            return OPUS_SIGNAL_VOICE
        case .music:
            return OPUS_SIGNAL_MUSIC
        }
    }
}

public enum ForwardErrorCorrection: Int32 {
    ///  Disable inband FEC (default).
    case disabled = 0
    /// Inband FEC enabled. If the packet loss rate is sufficiently high, Opus will automatically switch to SILK even at high rates to enable use of that FEC.
    case enabled = 1
    /// Inband FEC enabled, but does not necessarily switch to SILK if we have music.
    case enabledNoSwitch = 2
}