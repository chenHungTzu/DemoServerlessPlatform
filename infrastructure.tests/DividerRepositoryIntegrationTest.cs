using domain;
using domain.adapter;
using FluentAssertions;
using Microsoft.Extensions.DependencyInjection;
using misc;
using testbase;

namespace infrastructure.tests
{
    public class DividerRepositoryIntegrationTest : IntegrationTestBase, IClassFixture<IntegrationTestFixture>
    {
        private readonly IDividerRepository _dividerRepository;

        public DividerRepositoryIntegrationTest(IntegrationTestFixture integrationTestFixture) : base(integrationTestFixture)
        {
            _dividerRepository = integrationTestFixture.ServiceProvider.GetService<IDividerRepository>();
        }

        /// <summary>
        /// 是否正確寫入資料庫
        /// </summary>
        [Theory]
        [InlineData(0, "table0")]
        [InlineData(1, "table1")]
        [InlineData(2, "table2")]
        [InlineData(3, "table0")]
        public async Task Normal_repository_Should_be_True(int number, string target)
        {
            // arrange
            var divider = new Divider(number, 3);

            // act
            await _dividerRepository.WriteToDatabase(divider);

            // assert
            var resp = await ScanDynamoDBFrom($"{target}-{EnvironmentVariable.MODE()}");
            var actual = resp.First().Values.First().N;
            number.Should().Be(int.Parse(actual));
        }
    }
}