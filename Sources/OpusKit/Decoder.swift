import libopus
import Foundation

final public class Decoder {
    private let pointer: OpaquePointer
    private let channels: Channels

    init(sampleRate: Int32, channels: Channels) throws(OpusError) {
        self.channels = channels

        var errorCode: Int32 = 0
        self.pointer = opus_decoder_create(sampleRate, channels.rawValue, &errorCode)
        if errorCode != OPUS_OK {
            throw OpusError(rawValue: errorCode)
        }
    }

    deinit {
        opus_decoder_destroy(pointer)
    }

    /// Decode Opus data into raw PCM samples.
    /// - Parameters:
    ///   - input: The Opus-encoded input data.
    ///   - output: The output buffer to write the decoded PCM samples into.
    ///   - fec: Whether to use forward error correction.
    /// - Returns: The number of decoded samples per channel.
    func decode(_ input: Data, to output: inout Data, fec: Bool = false) throws(OpusError) -> Int32 {
        let decodedSamples = output.withUnsafeMutableBytes { outputBuffer in
            input.withUnsafeBytes { inputBuffer in
                let inputBuffer = inputBuffer.bindMemory(to: UInt8.self)
                let outputBuffer = outputBuffer.bindMemory(to: Int16.self)
                return opus_decode(
                    pointer,
                    inputBuffer.baseAddress!,
                    Int32(inputBuffer.count),
                    outputBuffer.baseAddress!,
                    Int32(outputBuffer.count) / channels.rawValue,
                    fec ? 1 : 0,
                )
            }
        }

        if decodedSamples < 0 {
            throw OpusError(rawValue: decodedSamples)
        }

        return decodedSamples
    }
}