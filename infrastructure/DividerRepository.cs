using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.Model;
using domain;
using domain.adapter;
using misc;

namespace infrastructure;

public class DividerRepository : IDividerRepository
{
    private readonly IAmazonDynamoDB _amazonDynamoDB;

    public DividerRepository(IAmazonDynamoDB amazonDynamoDB)
    {
        _amazonDynamoDB = amazonDynamoDB;
    }

    public async Task WriteToDatabase(Divider divider)
    {
        var request = new PutItemRequest
        {
            TableName = $"{divider.TableName}-{EnvironmentVariable.MODE()}",
            Item = new Dictionary<string, AttributeValue>
                {
                    { "Number", new AttributeValue { N = divider.Number.ToString() } }
                },
        };

        await _amazonDynamoDB.PutItemAsync(request);
    }
}