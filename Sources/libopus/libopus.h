#include <opus/opus.h>
#include <opus/opus_multistream.h>

static inline opus_get_application(OpusEncoder *st, opus_int32 *application) {
    opus_encoder_ctl(st, OPUS_GET_APPLICATION(application));
}

static inline opus_set_bitrate(OpusEncoder *st, opus_int32 bitrate) {
    opus_encoder_ctl(st, OPUS_SET_BITRATE(bitrate));
}1