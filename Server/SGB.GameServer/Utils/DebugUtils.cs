using System;
using System.Threading;

namespace SGB.GameServer.Utils
{
    public static class DebugUtils
    {
        public static void WriteLine(object value)
        {
#if DEBUG
            Logger.LogDebug(value);
#endif
        }
    }

    public static class Logger
    {
        private static readonly object AccessLock = new object();

        public static void LogInfo(object text, params object[] args)
        {
            lock (AccessLock)
            {
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Black;
                Log("Info", text, args);
            }
        }

        public static void LogWarning(object text, params object[] args)
        {
            lock (AccessLock)
            {
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.DarkYellow;
                Log("Warning", text, args);
            }
        }

        public static void LogError(object text, params object[] args)
        {
            lock (AccessLock)
            {
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.DarkRed;
                Log("Error", text, args);
            }
        }

        public static void LogDebug(object text, params object[] args)
        {
            lock (AccessLock)
            {
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Magenta;
                Log("Debug", text, args);
            }
        }

        private static void Log(string prefix, object text, params object[] args)
        {
            lock (AccessLock)
            {
#if RELEASE
            Console.WriteLine($"[{prefix}] @{DateTime.Now.ToString("HH:mm:ss")}] {text}", args);
#else
                Console.WriteLine($"[{prefix}] @{DateTime.Now:HH:mm:ss} {text}", args);
#endif
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Black;
            }
        }
    }
}
