using SGB.GameServer.Core;
using SGB.GameServer.Debug;
using SGB.GameServer.Resources;
using SGB.GameServer.Utils;
using SGB.Shared.Database;
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
                Environment.Exit(-1);

            Logger.LogDebug("Configuration Initialized");

            var success = GameLibrary.LoadFromFile(configuration.ResourceConfiguration.DirectoryPath);
            if (!success)
                Environment.Exit(-1);

            Logger.LogDebug("GameLibrary Loaded");

            success = RedisDB.Configure(configuration.DatabaseConfiguration.GetConnectionString(), configuration.DatabaseConfiguration.DatabaseIndex);
            if (!success)
                Environment.Exit(-1);

            Logger.LogDebug("RedisDB Configured");

            RunTests.Run();

            using var application = new Application(configuration);
            application.Run();
        }
    }
}