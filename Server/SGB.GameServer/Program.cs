using SGB.GameServer.Core;
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
#if DEBUG
            Thread.CurrentThread.Name = "Main Thread";
#endif

            Logger.LogInfo("Info Test");
            Logger.LogWarning("Warning Test");
            Logger.LogError("Error Test");
            Logger.LogDebug("Debug Test");


            var configPath = args.Length == 0 ? "GameServerConfig.Json" : args[0];
            var configuration = Configuration.Initialize(configPath);

            if (configuration == null)
                Environment.Exit(-1);

            DebugUtils.WriteLine("Configuration Initialized");

            var success = GameLibrary.LoadFromFile(configuration.ResourceConfiguration.DirectoryPath);
            if (!success)
                Environment.Exit(-1);

            DebugUtils.WriteLine("GameLibrary Loaded");

            using var application = new Application(configuration);
            application.Run();
        }
    }
}