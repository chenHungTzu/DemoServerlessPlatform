using Amazon.DynamoDBv2;
using Amazon.Runtime;
using domain.adapter;
using Microsoft.Extensions.DependencyInjection;
using misc;

namespace infrastructure.DI
{
    public static class DIExtension
    {

        public static IServiceCollection AddServices(this IServiceCollection services)
        {

            services.AddControllers();
            if (EnvironmentVariable.MODE() == "local")
            {
                services.AddSingleton<IAmazonDynamoDB>(_ =>
                {
                    var config = new AmazonDynamoDBConfig
                    {
                        ServiceURL = EnvironmentVariable.DDB_ENDPOINT(),
                        AuthenticationRegion = "ap-northeast-1",
                        UseHttp = true,
                    };
                    var awsCredentials = new BasicAWSCredentials("accesskey", "secretkey");
                    return new AmazonDynamoDBClient(awsCredentials, config);
                });
            }
            else
            {
                services.AddSingleton<IAmazonDynamoDB>(_ =>
                {
                    var clientConfig = new AmazonDynamoDBConfig
                    {
                        RegionEndpoint = Amazon.RegionEndpoint.APNortheast1
                    };
                    return new AmazonDynamoDBClient(clientConfig);
                });
            }
            services.AddSingleton<IDividerRepository, DividerRepository>();
            services.AddAWSLambdaHosting(LambdaEventSource.RestApi);

            return services;
        }
    }

}
