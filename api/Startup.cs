using Amazon.DynamoDBv2;
using Amazon.Runtime;
using domain.adapter;
using infrastructure;
using misc;

namespace DemoServerlessPlatform;

public class Startup
{
    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    // This method gets called by the runtime. Use this method to add services to the container
    public void ConfigureServices(IServiceCollection services)
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
    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (env.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
        }

        app.UseHttpsRedirection();

        app.UseRouting();

        app.UseAuthorization();

        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllers();
            endpoints.MapGet("/", async context =>
            {
                await context.Response.WriteAsync("Welcome to running ASP.NET Core on AWS Lambda");
            });
        });
    }
}