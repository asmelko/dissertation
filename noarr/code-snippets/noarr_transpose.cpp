template <typename bag_t>
void transpose_and_swap(bag_t lm, bag_t um)
{
    if (lm.get_length<'i'>() == 1) {
        std::swap(lm.at<'i', 'j'>(0, 0), um.at<'i', 'j'>(0, 0));
        return;
    }
    
    size_t hlen = lm.get_length<'i'>() / 2;
    transpose_and_swap(lm, um);
    transpose_and_swap(lm.shift<'j'>(hlen), um.shift<'j'>(hlen));
    transpose_and_swap(lm.shift<'i'>(hlen), um.shift<'i'>(hlen));
    transpose_and_swap(lm.shift<'i', 'j'>(hlen, hlen), um.shift<'i', 'j'>(hlen, hlen));
}

template <typename bag_t>
void transpose(bag_t m)
{
    if (m.get_length<'i'>() == 1)
        return;

    size_t hlen = m.get_length<'i'>() / 2;
    transpose(m);
    transpose_and_swap(m.shift<'i'>(hlen), m.shift<'j'>(hlen));
    transpose(m.shift<'i', 'j'>(hlen, hlen));
}

void main()
{
    using matrix_layout = #\noarr{}#::vector<'i', #\noarr{}#::vector<'j', #\noarr{}#::scalar<float>>>;
    using matrix_sequence = #\noarr{}#::vector<'m', matrix_layout>;

    auto layout_object = matrix_sequence() | #\noarr{}#::set_length<'i'>(H) |  #\noarr{}#::set_length<'j'>(W) |  #\noarr{}#::set_length<'m'>(matrices_count);
    void* matrices_to_transpose = /* initialize matrices */;

    for (size_t i = 0; i < matrices_count; ++i) {
        auto matrix = #\noarr{}#::make_bag(layout_object | #\noarr{}#::fix<'m'>(i), matrices_to_transpose);
        transpose(matrix);
    }
}
