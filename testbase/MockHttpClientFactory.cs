using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Extensions.DependencyInjection;

namespace testbase
{
    public class MockHttpClientFactory<T> : WebApplicationFactory<T> where T : class
    {
        private Action<IServiceCollection>? SlotDependency;

        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.ConfigureServices(services =>
            {
                SlotDependency?.Invoke(services);
            });
        }

        public MockHttpClient Create(Action<IServiceCollection>? slotDependency = null)
        {
            SlotDependency = slotDependency;

            var client = CreateClient();

            return new MockHttpClient(client);
        }
    }

    public class MockHttpClient
    {
        private readonly HttpClient _httpClient;

        public MockHttpClient(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<string> PostAsync(string endpoint)
        {
            HttpResponseMessage response = await _httpClient.PostAsync(endpoint, default);

            if (response.IsSuccessStatusCode == false)
                throw new Exception(response.ReasonPhrase);

            return await response.Content.ReadAsStringAsync(); ;
        }
    }
}