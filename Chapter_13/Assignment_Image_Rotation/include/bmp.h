struct __attribute__((packed)) bmp
{
    uint16_t Signature;
    uint32_t FileSize;
    uint32_t Reserved;
    uint32_t DataOffset;

    /* Info Header */
    uint32_t size;
    uint32_t Width;
    uint32_t Height;
    uint16_t Planes;
    uint16_t BitCount;
    uint32_t Compression;
    uint32_t ImageSize;
    uint32_t XpixelsPerM;
    uint32_t YpixelsPerM;
    uint32_t ColorsUsed;
    uint32_t ColorsImportant;
};

enum read_status {
READ_OK = 0,
READ_INVALID_SIGNATURE,
READ_INVALID_BITS,
READ_INVALID_HEADER
};
enum write_status {
WRITE_OK = 0,
WRITE_ERROR
};