using cube = #\noarr{}#::array<'x', 1048576, #\noarr{}#::array<'y', 32, #\noarr{}#::array<'z', 32, #\noarr{}#::scalar<float>>>>;
using bag = #\noarr{}#:bag<cube, #\noarr{}#::helpers::bag_policy<std::unique_ptr>>;

inline void stencil(const bag& in, bag& out, size_t x, size_t y, size_t z) {
    float sum = in.at<'x', 'y', 'z'>(x, y, z);
    sum += in.at<'x', 'y', 'z'>(x + 1, y, z);
    sum += in.at<'x', 'y', 'z'>(x - 1, y, z);
    sum += in.at<'x', 'y', 'z'>(x, y + 1, z);
    sum += in.at<'x', 'y', 'z'>(x, y - 1, z);
    sum += in.at<'x', 'y', 'z'>(x, y, z + 1);
    sum += in.at<'x', 'y', 'z'>(x, y, z - 1);
    out.at<'x', 'y', 'z'>(x, y, z) = sum / 7;
}