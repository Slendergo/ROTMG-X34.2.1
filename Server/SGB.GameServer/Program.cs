using SGB.GameServer.Core;
using SGB.GameServer.Resources;
using SGB.Shared;
using System;

namespace SGB.GameServer
{
    public sealed class Program
    {
        public static void Main(string[] args)
        {
            var configPath = args.Length == 0 ? "GameServerConfig.Json" : args[0];
            var configuration = Configuration.Initialize(configPath);

            if (configuration == null)
                throw new Exception(nameof(Configuration));

            var success = GameLibrary.LoadFromFile(configuration.ResourceConfiguration.DirectoryPath);
            if (!success)
                throw new Exception(nameof(GameLibrary));

            using var application = new Application(configuration);
            application.Run();
        }
    }
}