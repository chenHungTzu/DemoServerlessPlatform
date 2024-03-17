using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.Model;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

namespace testbase
{
    public class IntegrationTestBase : IAsyncLifetime
    {
        private IntegrationTestFixture integrationTestFixture { get; }

        protected IServiceProvider _serviceProvider { get; }


        public IntegrationTestBase(IntegrationTestFixture integrationTestFixture)
        {
            this.integrationTestFixture = integrationTestFixture;
            this._serviceProvider = integrationTestFixture.ServiceProvider;
        }

        public async Task DisposeAsync()
        {
            await Cleaner.Execute(_serviceProvider);
        }

        public async Task InitializeAsync()
        {

        }

        protected async Task<List<Dictionary<string, AttributeValue>>> ScanDynamoDBFrom(string tableName)
        {
            var amazoneDynamoDB = _serviceProvider.GetRequiredService<IAmazonDynamoDB>();
            var request = new ScanRequest
            {
                TableName = tableName
            };
            var response = await amazoneDynamoDB.ScanAsync(request);
            return  response.Items;
        }
    }
}