template <char X, char Y, typename bag_in_t, typename bag_out_t>
static void transform(const bag_in_t& input_bag, bag_out_t& output_bag)
{
    for (size_t i = 0; i < input_bag.get_length<X>(); i++)
        for (size_t j = 0; j < input_bag.get_length<Y>(); j++)
            output_bag.at<X, Y>(i, j) = input_bag.at<X, Y>(i, j);
}

template <class input_layout, class output_layout>
auto transform2bag(input_layout in_l, output_layout out_l, char* data)
{
    if constexpr (std::is_same_v<input_layout, desired_layout>) {
        return #\noarr{}#::make_bag(in_l, data);
    } else {
        auto input_bag = #\noarr{}#::make_bag(in_l, data);
        auto output_bag = #\noarr{}#::make_bag(out_l);
        transform(input_bag, output_bag);
        return output_bag;
    }
}