using SGB.GameServer.Core;

namespace SGB.GameServer
{
    public sealed class Program
    {
        public static void Main(string[] args)
        {
            var configPath = args.Length == 0 ? "GameServerConfig.Json" : args[0];
            var configuration = Configuration.Initialize(configPath);

            using var application = new Application(configuration);
            application.Run();
        }
    }
}