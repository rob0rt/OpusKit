#include <opus/opus.h>
#include <opus/opus_multistream.h>

// Wrapper functions for OpusEncoder/OpusDecoder control operations since Swift FFI
// does not support variadic functions or function-like macros.

// ============================================================================
// Encoder CTLs
// ============================================================================

static inline int opus_set_complexity(OpusEncoder *st, opus_int32 complexity) {
    return opus_encoder_ctl(st, OPUS_SET_COMPLEXITY(complexity));
}

static inline int opus_get_complexity(OpusEncoder *st, opus_int32 *complexity) {
    return opus_encoder_ctl(st, OPUS_GET_COMPLEXITY(complexity));
}

static inline int opus_set_bitrate(OpusEncoder *st, opus_int32 bitrate) {
    return opus_encoder_ctl(st, OPUS_SET_BITRATE(bitrate));
}

static inline int opus_get_bitrate(OpusEncoder *st, opus_int32 *bitrate) {
    return opus_encoder_ctl(st, OPUS_GET_BITRATE(bitrate));
}

static inline int opus_set_vbr(OpusEncoder *st, opus_int32 vbr) {
    return opus_encoder_ctl(st, OPUS_SET_VBR(vbr));
}

static inline int opus_get_vbr(OpusEncoder *st, opus_int32 *vbr) {
    return opus_encoder_ctl(st, OPUS_GET_VBR(vbr));
}

static inline int opus_set_vbr_constraint(OpusEncoder *st, opus_int32 vbr_constraint) {
    return opus_encoder_ctl(st, OPUS_SET_VBR_CONSTRAINT(vbr_constraint));
}

static inline int opus_get_vbr_constraint(OpusEncoder *st, opus_int32 *vbr_constraint) {
    return opus_encoder_ctl(st, OPUS_GET_VBR_CONSTRAINT(vbr_constraint));
}

static inline int opus_set_force_channels(OpusEncoder *st, opus_int32 force_channels) {
    return opus_encoder_ctl(st, OPUS_SET_FORCE_CHANNELS(force_channels));
}

static inline int opus_get_force_channels(OpusEncoder *st, opus_int32 *force_channels) {
    return opus_encoder_ctl(st, OPUS_GET_FORCE_CHANNELS(force_channels));
}

static inline int opus_set_max_bandwidth(OpusEncoder *st, opus_int32 max_bandwidth) {
    return opus_encoder_ctl(st, OPUS_SET_MAX_BANDWIDTH(max_bandwidth));
}

static inline int opus_get_max_bandwidth(OpusEncoder *st, opus_int32 *max_bandwidth) {
    return opus_encoder_ctl(st, OPUS_GET_MAX_BANDWIDTH(max_bandwidth));
}

static inline int opus_set_bandwidth(OpusEncoder *st, opus_int32 bandwidth) {
    return opus_encoder_ctl(st, OPUS_SET_BANDWIDTH(bandwidth));
}

static inline int opus_set_signal(OpusEncoder *st, opus_int32 signal) {
    return opus_encoder_ctl(st, OPUS_SET_SIGNAL(signal));
}

static inline int opus_get_signal(OpusEncoder *st, opus_int32 *signal) {
    return opus_encoder_ctl(st, OPUS_GET_SIGNAL(signal));
}

static inline int opus_set_application(OpusEncoder *st, opus_int32 application) {
    return opus_encoder_ctl(st, OPUS_SET_APPLICATION(application));
}

static inline int opus_get_application(OpusEncoder *st, opus_int32 *application) {
    return opus_encoder_ctl(st, OPUS_GET_APPLICATION(application));
}

static inline int opus_get_lookahead(OpusEncoder *st, opus_int32 *lookahead) {
    return opus_encoder_ctl(st, OPUS_GET_LOOKAHEAD(lookahead));
}

static inline int opus_set_inband_fec(OpusEncoder *st, opus_int32 inband_fec) {
    return opus_encoder_ctl(st, OPUS_SET_INBAND_FEC(inband_fec));
}

static inline int opus_get_inband_fec(OpusEncoder *st, opus_int32 *inband_fec) {
    return opus_encoder_ctl(st, OPUS_GET_INBAND_FEC(inband_fec));
}

static inline int opus_set_packet_loss_perc(OpusEncoder *st, opus_int32 packet_loss_perc) {
    return opus_encoder_ctl(st, OPUS_SET_PACKET_LOSS_PERC(packet_loss_perc));
}

static inline int opus_get_packet_loss_perc(OpusEncoder *st, opus_int32 *packet_loss_perc) {
    return opus_encoder_ctl(st, OPUS_GET_PACKET_LOSS_PERC(packet_loss_perc));
}

static inline int opus_set_dtx(OpusEncoder *st, opus_int32 dtx) {
    return opus_encoder_ctl(st, OPUS_SET_DTX(dtx));
}

static inline int opus_get_dtx(OpusEncoder *st, opus_int32 *dtx) {
    return opus_encoder_ctl(st, OPUS_GET_DTX(dtx));
}

static inline int opus_set_lsb_depth(OpusEncoder *st, opus_int32 lsb_depth) {
    return opus_encoder_ctl(st, OPUS_SET_LSB_DEPTH(lsb_depth));
}

static inline int opus_get_lsb_depth(OpusEncoder *st, opus_int32 *lsb_depth) {
    return opus_encoder_ctl(st, OPUS_GET_LSB_DEPTH(lsb_depth));
}

static inline int opus_set_expert_frame_duration(OpusEncoder *st, opus_int32 frame_duration) {
    return opus_encoder_ctl(st, OPUS_SET_EXPERT_FRAME_DURATION(frame_duration));
}

static inline int opus_get_expert_frame_duration(OpusEncoder *st, opus_int32 *frame_duration) {
    return opus_encoder_ctl(st, OPUS_GET_EXPERT_FRAME_DURATION(frame_duration));
}

static inline int opus_set_prediction_disabled(OpusEncoder *st, opus_int32 prediction_disabled) {
    return opus_encoder_ctl(st, OPUS_SET_PREDICTION_DISABLED(prediction_disabled));
}

static inline int opus_get_prediction_disabled(OpusEncoder *st, opus_int32 *prediction_disabled) {
    return opus_encoder_ctl(st, OPUS_GET_PREDICTION_DISABLED(prediction_disabled));
}

// ============================================================================
// Decoder CTLs
// ============================================================================

static inline int opus_decoder_set_gain(OpusDecoder *st, opus_int32 gain) {
    return opus_decoder_ctl(st, OPUS_SET_GAIN(gain));
}

static inline int opus_decoder_get_gain(OpusDecoder *st, opus_int32 *gain) {
    return opus_decoder_ctl(st, OPUS_GET_GAIN(gain));
}

static inline int opus_decoder_get_last_packet_duration(OpusDecoder *st, opus_int32 *duration) {
    return opus_decoder_ctl(st, OPUS_GET_LAST_PACKET_DURATION(duration));
}

static inline int opus_decoder_get_pitch(OpusDecoder *st, opus_int32 *pitch) {
    return opus_decoder_ctl(st, OPUS_GET_PITCH(pitch));
}

// ============================================================================
// Generic CTLs (work for both encoder and decoder)
// ============================================================================

static inline int opus_encoder_reset_state(OpusEncoder *st) {
    return opus_encoder_ctl(st, OPUS_RESET_STATE);
}

static inline int opus_decoder_reset_state(OpusDecoder *st) {
    return opus_decoder_ctl(st, OPUS_RESET_STATE);
}

static inline int opus_encoder_get_final_range(OpusEncoder *st, opus_uint32 *final_range) {
    return opus_encoder_ctl(st, OPUS_GET_FINAL_RANGE(final_range));
}

static inline int opus_decoder_get_final_range(OpusDecoder *st, opus_uint32 *final_range) {
    return opus_decoder_ctl(st, OPUS_GET_FINAL_RANGE(final_range));
}

static inline int opus_encoder_get_bandwidth(OpusEncoder *st, opus_int32 *bandwidth) {
    return opus_encoder_ctl(st, OPUS_GET_BANDWIDTH(bandwidth));
}

static inline int opus_decoder_get_bandwidth(OpusDecoder *st, opus_int32 *bandwidth) {
    return opus_decoder_ctl(st, OPUS_GET_BANDWIDTH(bandwidth));
}

static inline int opus_encoder_get_sample_rate(OpusEncoder *st, opus_int32 *sample_rate) {
    return opus_encoder_ctl(st, OPUS_GET_SAMPLE_RATE(sample_rate));
}

static inline int opus_decoder_get_sample_rate(OpusDecoder *st, opus_int32 *sample_rate) {
    return opus_decoder_ctl(st, OPUS_GET_SAMPLE_RATE(sample_rate));
}

static inline int opus_encoder_set_phase_inversion_disabled(OpusEncoder *st, opus_int32 phase_inversion_disabled) {
    return opus_encoder_ctl(st, OPUS_SET_PHASE_INVERSION_DISABLED(phase_inversion_disabled));
}

static inline int opus_encoder_get_phase_inversion_disabled(OpusEncoder *st, opus_int32 *phase_inversion_disabled) {
    return opus_encoder_ctl(st, OPUS_GET_PHASE_INVERSION_DISABLED(phase_inversion_disabled));
}

static inline int opus_decoder_set_phase_inversion_disabled(OpusDecoder *st, opus_int32 phase_inversion_disabled) {
    return opus_decoder_ctl(st, OPUS_SET_PHASE_INVERSION_DISABLED(phase_inversion_disabled));
}

static inline int opus_decoder_get_phase_inversion_disabled(OpusDecoder *st, opus_int32 *phase_inversion_disabled) {
    return opus_decoder_ctl(st, OPUS_GET_PHASE_INVERSION_DISABLED(phase_inversion_disabled));
}

static inline int opus_encoder_get_in_dtx(OpusEncoder *st, opus_int32 *in_dtx) {
    return opus_encoder_ctl(st, OPUS_GET_IN_DTX(in_dtx));
}

// ============================================================================
// Multistream Encoder CTLs
// ============================================================================

static inline int opus_ms_set_complexity(OpusMSEncoder *st, opus_int32 complexity) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_COMPLEXITY(complexity));
}

static inline int opus_ms_get_complexity(OpusMSEncoder *st, opus_int32 *complexity) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_COMPLEXITY(complexity));
}

static inline int opus_ms_set_bitrate(OpusMSEncoder *st, opus_int32 bitrate) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_BITRATE(bitrate));
}

static inline int opus_ms_get_bitrate(OpusMSEncoder *st, opus_int32 *bitrate) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_BITRATE(bitrate));
}

static inline int opus_ms_set_vbr(OpusMSEncoder *st, opus_int32 vbr) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_VBR(vbr));
}

static inline int opus_ms_get_vbr(OpusMSEncoder *st, opus_int32 *vbr) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_VBR(vbr));
}

static inline int opus_ms_set_vbr_constraint(OpusMSEncoder *st, opus_int32 vbr_constraint) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_VBR_CONSTRAINT(vbr_constraint));
}

static inline int opus_ms_get_vbr_constraint(OpusMSEncoder *st, opus_int32 *vbr_constraint) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_VBR_CONSTRAINT(vbr_constraint));
}

static inline int opus_ms_set_force_channels(OpusMSEncoder *st, opus_int32 force_channels) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_FORCE_CHANNELS(force_channels));
}

static inline int opus_ms_get_force_channels(OpusMSEncoder *st, opus_int32 *force_channels) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_FORCE_CHANNELS(force_channels));
}

static inline int opus_ms_set_max_bandwidth(OpusMSEncoder *st, opus_int32 max_bandwidth) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_MAX_BANDWIDTH(max_bandwidth));
}

static inline int opus_ms_get_max_bandwidth(OpusMSEncoder *st, opus_int32 *max_bandwidth) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_MAX_BANDWIDTH(max_bandwidth));
}

static inline int opus_ms_set_bandwidth(OpusMSEncoder *st, opus_int32 bandwidth) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_BANDWIDTH(bandwidth));
}

static inline int opus_ms_set_signal(OpusMSEncoder *st, opus_int32 signal) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_SIGNAL(signal));
}

static inline int opus_ms_get_signal(OpusMSEncoder *st, opus_int32 *signal) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_SIGNAL(signal));
}

static inline int opus_ms_set_application(OpusMSEncoder *st, opus_int32 application) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_APPLICATION(application));
}

static inline int opus_ms_get_application(OpusMSEncoder *st, opus_int32 *application) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_APPLICATION(application));
}

static inline int opus_ms_get_lookahead(OpusMSEncoder *st, opus_int32 *lookahead) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_LOOKAHEAD(lookahead));
}

static inline int opus_ms_set_inband_fec(OpusMSEncoder *st, opus_int32 inband_fec) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_INBAND_FEC(inband_fec));
}

static inline int opus_ms_get_inband_fec(OpusMSEncoder *st, opus_int32 *inband_fec) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_INBAND_FEC(inband_fec));
}

static inline int opus_ms_set_packet_loss_perc(OpusMSEncoder *st, opus_int32 packet_loss_perc) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_PACKET_LOSS_PERC(packet_loss_perc));
}

static inline int opus_ms_get_packet_loss_perc(OpusMSEncoder *st, opus_int32 *packet_loss_perc) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_PACKET_LOSS_PERC(packet_loss_perc));
}

static inline int opus_ms_set_dtx(OpusMSEncoder *st, opus_int32 dtx) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_DTX(dtx));
}

static inline int opus_ms_get_dtx(OpusMSEncoder *st, opus_int32 *dtx) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_DTX(dtx));
}

static inline int opus_ms_set_lsb_depth(OpusMSEncoder *st, opus_int32 lsb_depth) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_LSB_DEPTH(lsb_depth));
}

static inline int opus_ms_get_lsb_depth(OpusMSEncoder *st, opus_int32 *lsb_depth) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_LSB_DEPTH(lsb_depth));
}

static inline int opus_ms_set_expert_frame_duration(OpusMSEncoder *st, opus_int32 frame_duration) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_EXPERT_FRAME_DURATION(frame_duration));
}

static inline int opus_ms_get_expert_frame_duration(OpusMSEncoder *st, opus_int32 *frame_duration) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_EXPERT_FRAME_DURATION(frame_duration));
}

static inline int opus_ms_set_prediction_disabled(OpusMSEncoder *st, opus_int32 prediction_disabled) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_PREDICTION_DISABLED(prediction_disabled));
}

static inline int opus_ms_get_prediction_disabled(OpusMSEncoder *st, opus_int32 *prediction_disabled) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_PREDICTION_DISABLED(prediction_disabled));
}

static inline int opus_ms_get_encoder_state(OpusMSEncoder *st, OpusEncoder **encoder_state) {
    return opus_multistream_encoder_ctl(st, OPUS_MULTISTREAM_GET_ENCODER_STATE(encoder_state));
}

// ============================================================================
// Multistream Decoder CTLs
// ============================================================================

static inline int opus_ms_decoder_set_gain(OpusMSDecoder *st, opus_int32 gain) {
    return opus_multistream_decoder_ctl(st, OPUS_SET_GAIN(gain));
}

static inline int opus_ms_decoder_get_gain(OpusMSDecoder *st, opus_int32 *gain) {
    return opus_multistream_decoder_ctl(st, OPUS_GET_GAIN(gain));
}

static inline int opus_ms_decoder_get_last_packet_duration(OpusMSDecoder *st, opus_int32 *duration) {
    return opus_multistream_decoder_ctl(st, OPUS_GET_LAST_PACKET_DURATION(duration));
}

static inline int opus_ms_decoder_get_pitch(OpusMSDecoder *st, opus_int32 *pitch) {
    return opus_multistream_decoder_ctl(st, OPUS_GET_PITCH(pitch));
}

static inline int opus_ms_get_decoder_state(OpusMSDecoder *st, OpusDecoder **decoder_state) {
    return opus_multistream_decoder_ctl(st, OPUS_MULTISTREAM_GET_DECODER_STATE(decoder_state));
}

// ============================================================================
// Multistream Generic CTLs (work for both encoder and decoder)
// ============================================================================

static inline int opus_ms_encoder_reset_state(OpusMSEncoder *st) {
    return opus_multistream_encoder_ctl(st, OPUS_RESET_STATE);
}

static inline int opus_ms_decoder_reset_state(OpusMSDecoder *st) {
    return opus_multistream_decoder_ctl(st, OPUS_RESET_STATE);
}

static inline int opus_ms_encoder_get_final_range(OpusMSEncoder *st, opus_uint32 *final_range) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_FINAL_RANGE(final_range));
}

static inline int opus_ms_decoder_get_final_range(OpusMSDecoder *st, opus_uint32 *final_range) {
    return opus_multistream_decoder_ctl(st, OPUS_GET_FINAL_RANGE(final_range));
}

static inline int opus_ms_encoder_get_bandwidth(OpusMSEncoder *st, opus_int32 *bandwidth) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_BANDWIDTH(bandwidth));
}

static inline int opus_ms_decoder_get_bandwidth(OpusMSDecoder *st, opus_int32 *bandwidth) {
    return opus_multistream_decoder_ctl(st, OPUS_GET_BANDWIDTH(bandwidth));
}

static inline int opus_ms_encoder_get_sample_rate(OpusMSEncoder *st, opus_int32 *sample_rate) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_SAMPLE_RATE(sample_rate));
}

static inline int opus_ms_decoder_get_sample_rate(OpusMSDecoder *st, opus_int32 *sample_rate) {
    return opus_multistream_decoder_ctl(st, OPUS_GET_SAMPLE_RATE(sample_rate));
}

static inline int opus_ms_encoder_set_phase_inversion_disabled(OpusMSEncoder *st, opus_int32 phase_inversion_disabled) {
    return opus_multistream_encoder_ctl(st, OPUS_SET_PHASE_INVERSION_DISABLED(phase_inversion_disabled));
}

static inline int opus_ms_encoder_get_phase_inversion_disabled(OpusMSEncoder *st, opus_int32 *phase_inversion_disabled) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_PHASE_INVERSION_DISABLED(phase_inversion_disabled));
}

static inline int opus_ms_decoder_set_phase_inversion_disabled(OpusMSDecoder *st, opus_int32 phase_inversion_disabled) {
    return opus_multistream_decoder_ctl(st, OPUS_SET_PHASE_INVERSION_DISABLED(phase_inversion_disabled));
}

static inline int opus_ms_decoder_get_phase_inversion_disabled(OpusMSDecoder *st, opus_int32 *phase_inversion_disabled) {
    return opus_multistream_decoder_ctl(st, OPUS_GET_PHASE_INVERSION_DISABLED(phase_inversion_disabled));
}

static inline int opus_ms_encoder_get_in_dtx(OpusMSEncoder *st, opus_int32 *in_dtx) {
    return opus_multistream_encoder_ctl(st, OPUS_GET_IN_DTX(in_dtx));
}
