inline void stencil(const float* in, float* out, size_t x, size_t y, size_t z) {
    float sum = in[x * size_y * size_z + y * size_z + z];
    sum += in[(x + 1) * size_y * size_z + y * size_z + z];
    sum += in[(x - 1) * size_y * size_z + y * size_z + z];
    sum += in[x * size_y * size_z + (y + 1) * size_z + z];
    sum += in[x * size_y * size_z + (y - 1) * size_z + z];
    sum += in[x * size_y * size_z + y * size_z + z + 1];
    sum += in[x * size_y * size_z + y * size_z + z - 1];
    out[x * size_y * size_z + y * size_z + z] = sum / 7;
}