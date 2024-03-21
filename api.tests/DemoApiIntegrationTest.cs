using DemoServerlessPlatform;
using FluentAssertions;
using misc;
using testbase;

namespace api.tests;

public class DemoApiIntegrationTest : IntegrationTestBase, IClassFixture<IntegrationTestFixture>
{
    private MockHttpClient _httpClient { get; }

    public DemoApiIntegrationTest(IntegrationTestFixture integrationTestFixture) : base(integrationTestFixture)
    {
        _httpClient = new MockHttpClientFactory<Startup>().Create();
    }

    [Theory]
    [InlineData(0, "table0")]
    [InlineData(1, "table1")]
    [InlineData(2, "table2")]
    [InlineData(3, "table0")]
    public async Task Write_Database_Should_be_True(int number, string target)
    {
        var endpoint = $"/api/Demo/DivisionToWrite/{number}";

        var apiResp = await _httpClient.PostAsync(endpoint);
        int.Parse(apiResp).Should().Be(number);

        var resp = await ScanDynamoDBFrom($"{target}-{EnvironmentVariable.MODE()}");
        var actual = resp.First().Values.First().N;
        number.Should().Be(int.Parse(actual));
    }

    [Fact]
    public async Task Write_Database_Should_be_Throw()
    {
        var endpoint = $"/api/Demo/DivisionToWrite/{-1}";

        var ex = await Assert.ThrowsAsync<Exception>(() => _httpClient.PostAsync(endpoint));
    }
}