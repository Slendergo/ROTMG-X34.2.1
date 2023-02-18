using SGB.GameServer.Core;
using SGB.GameServer.Debug;
using SGB.GameServer.Resources;
using SGB.GameServer.Utils;
using System;
using System.Threading;

namespace SGB.GameServer
{
    public sealed class Program
    {
        public static void Main(string[] args)
        {
            RunTests.Run();

            var configPath = args.Length == 0 ? "GameServerConfig.Json" : args[0];
            var configuration = Configuration.Initialize(configPath);

            if (configuration == null)
                Environment.Exit(-1);

            Logger.LogDebug("Configuration Initialized");

            var success = GameLibrary.LoadFromFile(configuration.ResourceConfiguration.DirectoryPath);
            if (!success)
                Environment.Exit(-1);

            Logger.LogDebug("GameLibrary Loaded");

            using var application = new Application(configuration);
            application.Run();
        }
    }
}