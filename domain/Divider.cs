namespace domain;

public class Divider
{
    public Divider(int number, int divisor)
    {
        if (divisor <= 0)
        {
            throw new ArgumentException("Divisor cannot be zero or negative");
        }
        if (number < 0)
        {
            throw new ArgumentException("Number cannot be negative");
        }

        this.Number = number;
        this.Remainder = number % divisor;
    }

    public int Number { get; }

    public int Remainder { get; }

    public string TableName
    {
        get => this.Remainder switch
        {
            0 => "table0",
            1 => "table1",
            2 => "table2",
            _ => throw new ArgumentOutOfRangeException()
        };
    }
}