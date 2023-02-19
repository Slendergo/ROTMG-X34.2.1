using System;
using static System.Net.Mime.MediaTypeNames;

namespace SGB.GameServer.Utils
{
    public static class Logger
    {
        private static readonly object AccessLock = new object();

        public static void BlankSpace()
        {
            lock (AccessLock)
            {
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Black;
                Console.WriteLine();
            }
        }

        public static void NoPrefix(string text)
        {
            lock (AccessLock)
            {
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Black;
                Console.WriteLine(text);
            }
        }

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
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Black;
            }
        }

        public static void LogError(object text, params object[] args)
        {
            lock (AccessLock)
            {
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.DarkRed;
                Log("Error", text, args);
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Black;
            }
        }

        public static void LogDebug(object text, params object[] args)
        {
#if DEBUG
            lock (AccessLock)
            {
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Magenta;
                Log("Debug", text, args);
                Console.ForegroundColor = ConsoleColor.White;
                Console.BackgroundColor = ConsoleColor.Black;
            }
#endif
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
            }
        }
    }
}
