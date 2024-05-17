


int main()
{
    int n[80];

    #pragma omp tile sizes (4,4)
    for (int i =0; i < 10; i++)
    {
        for (int j = 0; j < 10; j++)
        {
            n[i] = j;
        }
    }

    return 0;
}