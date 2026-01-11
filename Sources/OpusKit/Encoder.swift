import libopus
import Foundation

final public class Encoder {
    private let pointer: OpaquePointer
    private let channels: Channels

    public init(sampleRate: SampleRate, channels: Channels, mode: Application) throws(OpusError) {
        self.channels = channels

        var errorCode: Int32 = 0
        self.pointer = opus_encoder_create(sampleRate.rawValue, channels.rawValue, mode.rawValue, &errorCode)
        if errorCode != OPUS_OK {
            throw OpusError(rawValue: errorCode)
        }
    }

    deinit {
        opus_encoder_destroy(pointer)
    }

    public func encode(_ input: Data, to output: inout Data) throws(OpusError) -> Int32 {
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

    // MARK: - Complexity

    /// Configures the encoder's computational complexity.
    /// 
    /// - Parameter complexity: The complexity level. 0-10 inclusive with 10 representing the highest complexity.
    public func setComplexity(_ complexity: Int32) throws(OpusError) {
        let result = opus_set_complexity(pointer, complexity)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    /// Gets the encoder's complexity configuration.
    /// 
    /// - Returns: The complexity level. 0-10 inclusive with 10 representing the highest complexity.
    public func getComplexity() throws(OpusError) -> Int32 {
        var complexity: Int32 = 0
        let result = opus_get_complexity(pointer, &complexity)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return complexity
    }

    // MARK: - Bitrate

    public func setBitrate(_ bitrate: Int32) throws(OpusError) {
        let result = opus_set_bitrate(pointer, bitrate)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    public func getBitrate() throws(OpusError) -> Int32 {
        var bitrate: Int32 = 0
        let result = opus_get_bitrate(pointer, &bitrate)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return bitrate
    }

    // MARK: - VBR (Variable Bitrate)

    public func setVBR(_ enabled: Bool) throws(OpusError) {
        let result = opus_set_vbr(pointer, enabled ? 1 : 0)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    public func getVBR() throws(OpusError) -> Bool {
        var vbr: Int32 = 0
        let result = opus_get_vbr(pointer, &vbr)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return vbr != 0
    }

    // MARK: - VBR Constraint

    public func setVBRConstraint(_ constrained: Bool) throws(OpusError) {
        let result = opus_set_vbr_constraint(pointer, constrained ? 1 : 0)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    public func getVBRConstraint() throws(OpusError) -> Bool {
        var constraint: Int32 = 0
        let result = opus_get_vbr_constraint(pointer, &constraint)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return constraint != 0
    }

    // MARK: - Force Channels

    public func setForceChannels(_ channels: Int32) throws(OpusError) {
        let result = opus_set_force_channels(pointer, channels)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    public func getForceChannels() throws(OpusError) -> Int32 {
        var channels: Int32 = 0
        let result = opus_get_force_channels(pointer, &channels)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return channels
    }

    // MARK: - Max Bandwidth

    public func setMaxBandwidth(_ bandwidth: Int32) throws(OpusError) {
        let result = opus_set_max_bandwidth(pointer, bandwidth)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    public func getMaxBandwidth() throws(OpusError) -> Int32 {
        var bandwidth: Int32 = 0
        let result = opus_get_max_bandwidth(pointer, &bandwidth)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return bandwidth
    }

    // MARK: - Bandwidth

    public func setBandwidth(_ bandwidth: Int32) throws(OpusError) {
        let result = opus_set_bandwidth(pointer, bandwidth)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    public func getBandwidth() throws(OpusError) -> Int32 {
        var bandwidth: Int32 = 0
        let result = opus_encoder_get_bandwidth(pointer, &bandwidth)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return bandwidth
    }

    // MARK: - Signal Type

    /// Configures the type of signal being encoded.
    /// This is a hint which helps the encoder's mode selection.
    public func setSignal(_ signal: Signal) throws(OpusError) {
        let result = opus_set_signal(pointer, signal.rawValue)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    /// Gets the encoder's configured signal type.
    /// 
    /// - Returns: The current signal type hint (or nil if an unrecognized value).
    public func getSignal() throws(OpusError) -> Signal? {
        var signal: Int32 = 0
        let result = opus_get_signal(pointer, &signal)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return Signal(rawValue: signal)
    }

    // MARK: - Application

    /// Configures the encoder's intended application.
    /// The initial value is a mandatory argument to the encoder_create function.
    public func setApplication(_ application: Application) throws(OpusError) {
        let result = opus_set_application(pointer, application.rawValue)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    /// Gets the encoder's configured application.
    /// 
    /// - Returns: The current application (or nil if an unrecognized value).
    public func getApplication() throws(OpusError) -> Application? {
        var application: Int32 = 0
        let result = opus_get_application(pointer, &application)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return Application(rawValue: application)
    }

    // MARK: - Lookahead

    /// Gets the total samples of delay added by the entire codec.
    /// This can be queried by the encoder and then the provided number of samples can be
    /// skipped on from the start of the decoder's output to provide time aligned input
    /// and output. From the perspective of a decoding application the real data begins this many
    /// samples late.
    ///
    /// The decoder contribution to this delay is identical for all decoders, but the
    /// encoder portion of the delay may vary from implementation to implementation,
    /// version to version, or even depend on the encoder's initial configuration.
    /// Applications needing delay compensation should call this CTL rather than
    /// hard-coding a value.
    /// 
    /// - Returns: The number of lookahead samples.
    public func getLookahead() throws(OpusError) -> Int32 {
        var lookahead: Int32 = 0
        let result = opus_get_lookahead(pointer, &lookahead)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return lookahead
    }

    // MARK: - Inband FEC (Forward Error Correction)

    /// Configures the encoder's use of inband forward error correction (FEC).
    public func setInbandFEC(_ fec: ForwardErrorCorrection) throws(OpusError) {
        let result = opus_set_inband_fec(pointer, fec.rawValue)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    /// Gets encoder's configured use of inband forward error correction.
    /// 
    /// - Returns: The current FEC setting (or nil if an unrecognized value).
    public func getInbandFEC() throws(OpusError) -> ForwardErrorCorrection? {
        var fec: Int32 = 0
        let result = opus_get_inband_fec(pointer, &fec)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return ForwardErrorCorrection(rawValue: fec)
    }

    // MARK: - Packet Loss Percentage

    /// Configures the encoder's expected packet loss percentage.
    /// Higher values trigger progressively more loss resistant behavior in the encoder
    /// at the expense of quality at a given bitrate in the absence of packet loss, but
    /// greater quality under loss.
    /// 
    /// - Parameter percentage: Loss percentage in the range 0-100, inclusive (default: 0).
    public func setPacketLossPercentage(_ percentage: Int32) throws(OpusError) {
        let result = opus_set_packet_loss_perc(pointer, percentage)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    /// Gets the encoder's configured packet loss percentage.
    /// 
    /// - Returns: The configured loss percentage in the range 0-100, inclusive (default: 0).
    public func getPacketLossPercentage() throws(OpusError) -> Int32 {
        var percentage: Int32 = 0
        let result = opus_get_packet_loss_perc(pointer, &percentage)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return percentage
    }

    // MARK: - DTX (Discontinuous Transmission)

    /// Configures the encoder's use of discontinuous transmission (DTX).
    /// - Note: This is only applicable to the LPC layer
    public func setDTX(_ enabled: Bool) throws(OpusError) {
        let result = opus_set_dtx(pointer, enabled ? 1 : 0)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    /// Gets encoder's configured use of discontinuous transmission.
    public func getDTX() throws(OpusError) -> Bool {
        var dtx: Int32 = 0
        let result = opus_get_dtx(pointer, &dtx)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return dtx != 0
    }

    // MARK: - LSB Depth

    /// Configures the depth of signal being encoded.
    ///
    /// This is a hint which helps the encoder identify silence and near-silence.
    /// It represents the number of significant bits of linear intensity below
    /// which the signal contains ignorable quantization or other noise.
    ///
    /// For example, OPUS_SET_LSB_DEPTH(14) would be an appropriate setting
    /// for G.711 u-law input. OPUS_SET_LSB_DEPTH(16) would be appropriate
    /// for 16-bit linear pcm input with opus_encode_float().
    ///
    /// When using opus_encode() instead of opus_encode_float(), or when libopus
    /// is compiled for fixed-point, the encoder uses the minimum of the value
    /// set here and the value 16.
    ///
    /// - Parameter depth: Input precision in bits, between 8 and 24 (default: 24).
    public func setLSBDepth(_ depth: Int32) throws(OpusError) {
        let result = opus_set_lsb_depth(pointer, depth)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    /// Gets the encoder's configured signal depth.
    ///
    /// - Returns: Input precision in bits, between 8 and 24 (default: 24).
    public func getLSBDepth() throws(OpusError) -> Int32 {
        var depth: Int32 = 0
        let result = opus_get_lsb_depth(pointer, &depth)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return depth
    }

    // MARK: - Expert Frame Duration

    public func setExpertFrameDuration(_ duration: Int32) throws(OpusError) {
        let result = opus_set_expert_frame_duration(pointer, duration)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    public func getExpertFrameDuration() throws(OpusError) -> Int32 {
        var duration: Int32 = 0
        let result = opus_get_expert_frame_duration(pointer, &duration)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return duration
    }

    // MARK: - Prediction

    public func setPredictionDisabled(_ disabled: Bool) throws(OpusError) {
        let result = opus_set_prediction_disabled(pointer, disabled ? 1 : 0)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    public func getPredictionDisabled() throws(OpusError) -> Bool {
        var disabled: Int32 = 0
        let result = opus_get_prediction_disabled(pointer, &disabled)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return disabled != 0
    }

    // MARK: - Generic CTLs

    public func resetState() throws(OpusError) {
        let result = opus_encoder_reset_state(pointer)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    public func getFinalRange() throws(OpusError) -> UInt32 {
        var finalRange: UInt32 = 0
        let result = opus_encoder_get_final_range(pointer, &finalRange)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return finalRange
    }

    public func getSampleRate() throws(OpusError) -> Int32 {
        var sampleRate: Int32 = 0
        let result = opus_encoder_get_sample_rate(pointer, &sampleRate)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return sampleRate
    }

    // MARK: - Phase Inversion

    public func setPhaseInversionDisabled(_ disabled: Bool) throws(OpusError) {
        let result = opus_encoder_set_phase_inversion_disabled(pointer, disabled ? 1 : 0)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
    }

    public func getPhaseInversionDisabled() throws(OpusError) -> Bool {
        var disabled: Int32 = 0
        let result = opus_encoder_get_phase_inversion_disabled(pointer, &disabled)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return disabled != 0
    }

    // MARK: - DTX State

    /// Gets the DTX state of the encoder.
    ///
    /// - Returns: whether the last encoded frame was either a comfort noise update
    ///   during DTX or not encoded because of DTX.
    public func getInDTX() throws(OpusError) -> Bool {
        var inDTX: Int32 = 0
        let result = opus_encoder_get_in_dtx(pointer, &inDTX)
        if result != OPUS_OK {
            throw OpusError(rawValue: result)
        }
        return inDTX != 0
    }
}
