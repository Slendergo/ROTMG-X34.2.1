using SGB.GameServer.Utils;
using System;
using System.IO;
using System.Text.Json;
using System.Threading.Tasks;

namespace SGB.GameServer.Core
{
    public static class Configuration
    {
        public static ConfigurationData GetConfiguration()
        {
            lock (SwapLock)
            {
                return ConfigurationData;
            }
        }

        public static ConfigurationData Initialize(string path)
        {
            ConfigurationPath = path;
            return ConfigurationData = ParseConfiguration();
        }

        private static ConfigurationData ParseConfiguration()
        {
            if (!File.Exists(ConfigurationPath))
                return null;

            var fileJson = File.ReadAllText(ConfigurationPath);
            try
            {
                return JsonSerializer.Deserialize<ConfigurationData>(fileJson, new JsonSerializerOptions()
                {
                    PropertyNameCaseInsensitive = true,
                });
            }
            catch (Exception ex)
            {
                DebugUtils.WriteLine($"[Configuration::ParseConfiguration()] {ex}");
            }
            return null;
        }

        // is this needed????? probably not lets do anyway
        public static async void ReloadAsync()
        {
            await Task.Run(() =>
            {
                var newConfigurationData = ParseConfiguration();
                lock (SwapLock)
                {
                    ConfigurationData = newConfigurationData;
                }
            });
        }

        private static string ConfigurationPath;
        private static ConfigurationData ConfigurationData;
        private static readonly object SwapLock = new object();
    }

    public sealed class ConfigurationData
    {
        public ServerConfiguration ServerConfiguration { get; set; }
        public ResourceConfiguration ResourceConfiguration { get; set; }
        public IOConfiguration IOConfiguration { get; set; }
        public AnnouncerConfiguration AnnouncerConfiguration { get; set; }
        public AutomatedRestartConfiguration AutomatedRestartConfiguration { get; set; }
        public ChatConfiguration ChatConfiguration { get; set; }
        public SessionConfiguration SessionConfiguration { get; set; }
        public LoggingConfiguration LoggingConfiguration { get; set; }
        public RealmConfiguration RealmConfiguration { get; set; }
        public TestingConfiguration TestingConfiguration { get; set; }
    }

    public sealed class ServerConfiguration
    {
        public string BuildVersion { get; set; }
    }

    public sealed class ResourceConfiguration
    {
        public string DirectoryPath { get; set; }
    }

    public sealed class IOConfiguration
    {
        public int StartingSessionCacheCount { get; set; }
        public int Backlog { get; set; }
        public int Port { get; set; }
    }

    public sealed class AnnouncerConfiguration
    {
        public bool CyclicAnnouncements { get; set; }
        public int RarelyPeriodMinutes { get; set; }
        public string[] Rarely { get; set; }
        public int OftenPeriodMinutes { get; set; }
        public string[] Periodically { get; set; }
        public int FrequentPeriodMinutes { get; set; }
        public string[] Frequent { get; set; }
    }

    public sealed class AutomatedRestartConfiguration
    {
        public int HoursBeforeRestart { get; set; }
        public string RestartMessage15Minutes { get; set; }
        public string RestartMessage30Seconds { get; set; }
        public string RestartMessage15Seconds { get; set; }
        public string RestartMessage5Seconds { get; set; }
    }

    public sealed class ChatConfiguration
    {
        public int SpamTimeoutMS { get; set; }
        public int SpamThreshold { get; set; }
        public int StarRequirement { get; set; }
    }

    public sealed class SessionConfiguration
    {
        public int MaxSessions { get; set; }
    }

    public sealed class LoggingConfiguration
    {
        public bool EnableLogging { get; set; }
    }

    public sealed class RealmConfiguration
    {
        public int MaxPlayers { get; set; }
        public int MaxRealms { get; set; }
        public int StartingRealms { get; set; }
    }

    public sealed class TestingConfiguration
    {
        public int StartingLevel { get; set; }
        public int StartingHealthPotions { get; set; }
        public int StartingMagicPotions { get; set; }
        public int PermanentFameAmount { get; set; }
        public int PermanentCreditsAmount { get; set; }
        public StartingItem[] StartingItems { get; set; }
    }

    public sealed class StartingItem
    {
        public string IdName { get; set; }
        public string Weapon { get; set; }
        public string Ability { get; set; }
        public string Armor { get; set; }
        public string Ring { get; set; }
    }
}