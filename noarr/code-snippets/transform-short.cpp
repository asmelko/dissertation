template <char X, char Y, typename bag_in_t, typename bag_out_t>
static void transform(const bag_in_t& input_bag, bag_out_t& output_bag) {
    for (size_t i = 0; i < input_bag.get_length<X>(); i++)
        for (size_t j = 0; j < input_bag.get_length<Y>(); j++)
            output_bag.at<X, Y>(i, j) = input_bag.at<X, Y>(i, j);
}
