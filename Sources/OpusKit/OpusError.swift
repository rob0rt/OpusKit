import libopus
import Foundation

/// Represents errors that can occur in the Opus codec.
public enum OpusError: LocalizedError {
    /// One or more invalid/out of range arguments
    case badArgument
    /// Not enough bytes allocated in the buffer
    case bufferTooSmall
    /// An internal error was detected
    case internalError
    /// The compressed data passed is corrupted
    case invalidPacket
    /// Invalid/unsupported request number
    case unimplemented
    /// An encoder or decoder structure is invalid or already freed
    case invalidState
    /// Memory allocation has failed
    case allocFail
    /// libopus returned an unknown error code (ret < 0)
    case unknown(Int32)

    public var errorDescription: String? {
        String(cString: opus_strerror(rawValue))
    }

    public init(rawValue: Int32) {
        switch rawValue {
            case OPUS_BAD_ARG:
                self = .badArgument
            case OPUS_BUFFER_TOO_SMALL:
                self = .bufferTooSmall
            case OPUS_INTERNAL_ERROR:
                self = .internalError
            case OPUS_INVALID_PACKET:
                self = .invalidPacket
            case OPUS_UNIMPLEMENTED:
                self = .unimplemented
            case OPUS_INVALID_STATE:
                self = .invalidState
            case OPUS_ALLOC_FAIL:
                self = .allocFail
            default:
                self = .unknown(rawValue)
        }
    }

    public var rawValue: Int32 {
        switch self {
        case .badArgument:
            return OPUS_BAD_ARG
        case .bufferTooSmall:
            return OPUS_BUFFER_TOO_SMALL
        case .internalError:
            return OPUS_INTERNAL_ERROR
        case .invalidPacket:
            return OPUS_INVALID_PACKET
        case .unimplemented:
            return OPUS_UNIMPLEMENTED
        case .invalidState:
            return OPUS_INVALID_STATE
        case .allocFail:
            return OPUS_ALLOC_FAIL
        case .unknown(let code):
            return code
        }
    }
}