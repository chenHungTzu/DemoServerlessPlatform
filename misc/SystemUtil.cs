using System.Net.Sockets;

namespace misc
{
      public class SystemUtil
    {
        public static void WaitTCPPortOpen((string IP, int Port)[] ipAddress)
        {
            while (true)
            {
                var result = ipAddress.Select(x => IsTCPPortOpen(x.IP, x.Port));

                if (result.All(x => x == true))
                {
                    Console.WriteLine("[WaitTestEnvPortOpen] OK");
                    break;
                }
                Console.WriteLine("[WaitTestEnvPortOpen] Wait...");
            }
        }

        public static bool IsTCPPortOpen(string ip, int port)
        {
            using (TcpClient tcpClient = new TcpClient())
            {
                try
                {
                    tcpClient.Connect(ip, port);
                    return true;
                }
                catch (Exception)
                {
                    return false;
                }
            }
        }
    }
}