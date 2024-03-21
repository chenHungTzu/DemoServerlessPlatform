using FluentAssertions;

namespace domain.tests
{
    public class DividerUnitTest
    {
        /// <summary>
        /// 驗證基本除法是否正常
        /// </summary>
        /// <param name="number"></param>
        /// <param name="remainder"></param>
        [Theory]
        [InlineData(0, 0)]
        [InlineData(1, 1)]
        [InlineData(2, 2)]
        [InlineData(3, 0)]
        public void Divider_Should_be_True(int number, int remainder)
        {
            var divider = new Divider(number, 3);
            divider.Remainder.Should().Be(remainder);
            divider.Number.Should().Be(number);
        }

        /// <summary>
        /// 當被除數為負數時，應該要拋出例外
        /// </summary>
        [Fact]
        public void Divider_When_Number_Negative_Should_be_Throw()
        {
            var ex = Assert.Throws<ArgumentException>(() => new Divider(-1, 3));
            var expect = "Number cannot be negative";
            ex.Message.Should().Be(expect);
        }

        /// <summary>
        /// 當除數為0或負數時，應該要拋出例外
        /// </summary>
        /// <param name="divisor"></param>
        [Theory]
        [InlineData(0)]
        [InlineData(-1)]
        public void Divider_When_Divisor_Zero_Should_be_Throw(int divisor)
        {
            var ex = Assert.Throws<ArgumentException>(() => new Divider(1, divisor));
            var expect = "Divisor cannot be zero or negative";
            ex.Message.Should().Be(expect);
        }

        /// <summary>
        /// 驗證table指向是否正確
        /// </summary>
        /// <param name="number"></param>
        /// <param name="target"></param>
        [Theory]
        [InlineData(0, "table0")]
        [InlineData(1, "table1")]
        [InlineData(2, "table2")]
        [InlineData(3, "table0")]
        public void Table_Name_Should_be_True(int number, string target)
        {
            var divider = new Divider(number, 3);
            divider.TableName.Should().Be(target);
        }

        /// <summary>
        /// 驗證table不存在，應拋出例外
        /// </summary>
        [Fact]
        public void Table_Name_Not_Exist_Should_be_Throw()
        {
            var ex = Assert.Throws<ArgumentOutOfRangeException>(() => new Divider(3, 4).TableName);
        }
    }
}