using Amazon;

namespace misc
{
    public class EnvironmentVariable
    {
        public static string MODE() => GetEnvironmentVariable(nameof(MODE), "local");
        public static string DDB_REGION() => GetEnvironmentVariable(nameof(DDB_REGION), RegionEndpoint.APNortheast1.ToString());
        public static string DDB_ENDPOINT() => GetEnvironmentVariable(nameof(DDB_ENDPOINT), "http://host.docker.internal:4566"); //host.docker.internal

        private static string GetEnvironmentVariable(string name, string defaultValue)
        {
            var variable = Environment.GetEnvironmentVariable(name);
            if (string.IsNullOrWhiteSpace(variable))
            {
                if (defaultValue == null)
                    throw new ArgumentNullException($"EnvironmentVariable({name}) was required.");

                return defaultValue;
            }

            return variable;
        }
    }


}