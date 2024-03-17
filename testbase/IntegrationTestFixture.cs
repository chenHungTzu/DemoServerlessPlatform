using Microsoft.Extensions.DependencyInjection;
using infrastructure.DI;
using misc;

namespace testbase
{
    public class IntegrationTestFixture
    {
        public readonly IServiceProvider ServiceProvider;

         public IntegrationTestFixture()
        {
            SystemUtil.WaitTCPPortOpen(new[] {
                ("127.0.0.1" , 4566)
            });

            SetEnviroments();

            var _serviceCollection = new ServiceCollection();
            _serviceCollection.AddServices();
            ServiceProvider = _serviceCollection.BuildServiceProvider();
        }

        private void SetEnviroments()
        {
            Environment.SetEnvironmentVariable(nameof(EnvironmentVariable.MODE), "local");
            Environment.SetEnvironmentVariable(nameof(EnvironmentVariable.DDB_ENDPOINT), "http://127.0.0.1:4566");
           
        }
    }

   

}