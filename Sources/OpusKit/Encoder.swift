import libopus
import Foundation

final public class Encoder {
    private let pointer: OpaquePointer
    private let channels: Channels

    init(sampleRate: Int32, channels: Channels, mode: Application) throws(OpusError) {
        self.channels = channels

        var errorCode: Int32 = 0
        self.pointer = opus_encoder_create(sampleRate, channels.rawValue, mode.rawValue, &errorCode)
        if errorCode != OPUS_OK {
            throw OpusError(rawValue: errorCode)
        }        
    }

    deinit {
        opus_encoder_destroy(pointer)
    }

    func encode(_ input: Data, to output: inout Data) throws(OpusError) -> Int32 {
        let encodedPacketLength = output.withUnsafeMutableBytes { outputBuffer in
            input.withUnsafeBytes { inputBuffer in
                let inputBuffer = inputBuffer.bindMemory(to: Int16.self)
                let outputBuffer = outputBuffer.bindMemory(to: UInt8.self)
                return opus_encode(
                    pointer,
                    inputBuffer.baseAddress!,
                    Int32(inputBuffer.count) / channels.rawValue,
                    outputBuffer.baseAddress!,
                    Int32(outputBuffer.count),
                )
            }
        }

        if encodedPacketLength < 0 {
            throw OpusError(rawValue: encodedPacketLength)
        }

        return encodedPacketLength
    }

    func get_application() -> Application? {
        var application: Int32 = 0
        opus_get_application(pointer, &application)
        return Application(rawValue: application)
    }
}
